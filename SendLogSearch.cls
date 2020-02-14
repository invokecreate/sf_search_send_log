public with sharing class SendLog {
    @testVisible private static String makeJSONPostCall(String endPoint, String restBody, String token){
        Http h = new Http();
        HttpRequest r = new HttpRequest();
        r.setTimeout(60000);
        r.setEndpoint(endPoint);  
        r.setMethod('POST');
        r.setHeader('Content-type','application/json'); 
        if(!String.isEmpty(token)){
        r.setHeader('Authorization', 'Bearer ' + token);
        }
        r.setBody(restBody);    
        HttpResponse res = h.send(r);
        return res.getBody();
    }
    private static String MARKETING_CLOUD_AUTH_URL = YOURAUTHURL;
    private static String ACCESS_TOKEN = 'access_token';
    private static String ClientID = CLIENTID;
    private static String ClientSecret = CLIENTSECRET;
    private static String sendLogURL = 'https://www.exacttargetapis.com/data/v1/customobjectdata/key/SendLog/rowset?$page=1&$pageSize=5&$orderBy=send_date&$filter=emailaddr=';
    @AuraEnabled
    public static String getMarketingCloudToken(){
        String responseBody = makeJSONPostCall(
            MARKETING_CLOUD_AUTH_URL,
            JSON.serialize( new Map<String, String>{
                'grant_type': 'client_credentials'
                    'clientId' => ClientID,
                        'clientSecret' => ClientSecret
                            'account_id': YOURMID
                    } ), NULL
        );
        return ((Map<String, String>) JSON.deserialize(responseBody, Map<String, String>.class)).get( ACCESS_TOKEN ); 
    }
    @AuraEnabled
    public static String searchSendLog(String Email) {
            String authToken = getMarketingCloudToken();
            Http h = new Http();
            HttpRequest webReq = new HttpRequest();
            webReq.setMethod('GET');
            webReq.setHeader('Authorization','Bearer '+ authToken);
            webReq.setEndpoint(sendLogURL + '"' + Email + '"');
            HttpResponse res = h.send(webReq);
            String response = res.getbody();
            return response;
    }
}