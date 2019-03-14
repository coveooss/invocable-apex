@isTest
public class CoveoResultTest {
    private static String TITLE_TEST = 'Coveo Facet Component (CoveoFacet)';
    private static String FILENAME_TEST = 'facet.html';
    private static Integer INTEGER_TEST = 12345;
    private static String VALID_JSON_EMPTY = '{}';
    private static String FAKE_RESULT_JSON = '{"title":"Coveo Facet Component (CoveoFacet)","clickUri":"https://coveo.github.io/search-ui/components/facet.html","excerpt":"The Facet component displays a facet of the results for the current query. ... A facet is a list of values for a certain field occurring in the results, ordered using a configurable criteria (e.g.,...","isTopResult":false,"isRecommendation":true,"rankingModifier":"Reveal ART","raw":{"sysfilename":"facet.html","urihash":"r7T0QBbuRY1p2rSj","common_interestedin":"Technical Documentation","permanentid":"75f6a9bc754364ac883c3251eabe27e9fd1192113cc2406b6f7497aab4a1","common_category":"JavaScript Search Framework Reference","title":"Coveo Facet Component (CoveoFacet)","date":1551733684000,"number":12345,"bool_field":true,"double_field":3.1416,"objecttype":"JavaScript Search Reference","audience":["Developer"],"filename":"facet.html","sourcetype":"Web","source":"JsSearchRef","common_resourcetype":"JavaScript Search Framework API","syssourcetype":"Web","filetype":"html","common_userintent":"Learn","common_hostname_and_path":"coveo.github.io/search-ui/","sysfiletype":"html","language":["English"],"sitename":"JavaScript Search Components","uri":"https://coveo.github.io/search-ui/components/facet.html"}}';

    private static Object createFakeResultObject(String jsonInput) {
        return JSON.deserializeUntyped(jsonInput);
    }

    @isTest static void testDeserializeFromObject() {
        Object myFakeResult = createFakeResultObject(FAKE_RESULT_JSON);
        CoveoResult myCoveoResult = new CoveoResult();
        System.assert(myCoveoResult.deserializeFromObject(myFakeResult));
        System.assertEquals(myCoveoResult.title, TITLE_TEST);
        System.assert(myCoveoResult.isRecommendation);
    }

    @isTest static void testCreateFromMap() {
        Map<String,Object> myFakeResult = (Map<String,Object>)createFakeResultObject(FAKE_RESULT_JSON);
        CoveoResult myCoveoResult = new CoveoResult(myFakeResult);
        System.assert(myCoveoResult.deserializeFromObject(myFakeResult));
        System.assertEquals(myCoveoResult.title, TITLE_TEST);
        System.assert(myCoveoResult.isRecommendation);
    }

    @isTest static void testGetRawProperty() {
        Object myFakeResult = createFakeResultObject(FAKE_RESULT_JSON);
        CoveoResult myCoveoResult = new CoveoResult();
        System.assert(myCoveoResult.deserializeFromObject(myFakeResult));
        System.assertEquals((String)myCoveoResult.getRawProperty('filename'), FILENAME_TEST);
        // Get a raw property that doesn't exist, should receive an empty string.
        System.assertEquals((String)myCoveoResult.getRawProperty('keythatdoesntexist'), '');
    }

    @isTest static void testEmptyResponse() {
        Object myFakeResult = createFakeResultObject(VALID_JSON_EMPTY);
        CoveoResult myCoveoResult = new CoveoResult();
        System.assert(myCoveoResult.deserializeFromObject(myFakeResult));
        // Any raw key should return an empty value even if it doesn't exist.
        System.assertEquals((String)myCoveoResult.getRawProperty('filename'), '');
        System.assert(String.isBlank(myCoveoResult.title));
    }

    @isTest static void testReturnTypes() {
        Object myFakeResult = createFakeResultObject(FAKE_RESULT_JSON);
        CoveoResult myCoveoResult = new CoveoResult();
        System.assert(myCoveoResult.deserializeFromObject(myFakeResult));
        System.assert(String.isNotBlank(myCoveoResult.getRawPropertyAsString('common_interestedin')));
        System.assert(myCoveoResult.getRawProperty('date') instanceof Long);
        System.assertEquals(myCoveoResult.getRawPropertyAsDateTime('date'), DateTime.newInstance((Long)myCoveoResult.getRawProperty('date')));
        System.assert(myCoveoResult.getRawProperty('number') instanceof Integer);
        System.assertEquals(myCoveoResult.getRawPropertyAsInteger('number'), INTEGER_TEST);
        System.assert(myCoveoResult.getRawProperty('bool_field') instanceof Boolean);
        System.assert(myCoveoResult.getRawPropertyAsBoolean('bool_field'));
        System.assert(myCoveoResult.getRawProperty('double_field') instanceof Double);
        System.assertEquals(myCoveoResult.getRawPropertyAsDouble('double_field'), 3.1416);
    }
}
