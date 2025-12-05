

class ApiConstants {

  // Base URL
  static const String baseURL = 'https://api.coingecko.com/api/v3';

  // Endpoints 
  static const String cryptoMarketsEndpoint = '/coins/markets';
  static const String cryptoDetailsEndpoint = '/coins';

  // Parameters 
  static const String defaultCurrency = 'usd';
  static const int perPage = 20; 
  static const int cacheTimeoutSeconds = 20;
  static const int requestLimitPerMinute = 50;

  // Full URLs
  static String getMarketsUrl({
    int page = 1,
    String currency = defaultCurrency,
  }){

    return '$baseURL$cryptoMarketsEndpoint'
        '?vs_currency=$currency'
        '&order=market_cap_desc'
        '&per_page=$perPage'
        '&page=$page'
        '&sparkline=false';
  }

  static String getCryptoDetailsUrl(String cryptoId){
    return '$baseURL$cryptoDetailsEndpoint/$cryptoId'
        '?localization=false'
        '&tickers=false'
        '&market_data=true'
        '&community_data=false'
        '&developer_data=false';
  }

  static String getMarketChartUrl(String cryptoId){
    return '$baseURL$cryptoDetailsEndpoint/$cryptoId/market_chart'
        '?vs_currency=$defaultCurrency'
        '&days=7'
        '&interval=daily';
  }
}