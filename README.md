[![Gem Version](https://img.shields.io/gem/v/bing-ads.svg)](https://rubygems.org/gems/bing-ads)
[![Build Status](https://travis-ci.org/FindHotel/bing-ads.svg?branch=master)](https://travis-ci.org/FindHotel/bing-ads)

## We have not tested all pieces of functionality for this gem!
Please look [here](https://docs.microsoft.com/en-us/bingads/guides/migration-guide?view=bingads-12) if you're using this gem to make sure that the functionality you're looking for didn't experience a breaking change

# Bing::Ads

## An ezcater fork of a Bing Ads API client

We forked this repo in order to upgrade to API V12.

A Ruby client for Bing Ads API that includes a proxy to all Bing Ads API web services and abstracts low level details of authentication with OAuth.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bing-ads'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bing-ads

## Usage

### Customer Management Service
#### Initialization
```ruby
# Authentication token is not supported in sandbox, use `username` and `password` instead
# https://msdn.microsoft.com/en-us/library/dn277356.aspx

options = {
  environment: :sandbox,
  authentication_token: '39b290146bea6ce975c37cfc23',
  developer_token: 'BBD37VB98',
  customer_id: '21027149',
  # client_settings: { logger: LOGGER::STDOUT }
}

service = Bing::Ads::API::V12::Services::CustomerManagement.new(options)
```

#### Getting accounts info
```ruby
response = service.get_accounts_info
```

### Campaign Management Service
#### Initialization
```ruby
# Authentication token is not supported in sandbox, use `username` and `password` instead
# https://msdn.microsoft.com/en-us/library/dn277356.aspx

options = {
  environment: :sandbox,
  authentication_token: '39b290146bea6ce975c37cfc23',
  developer_token: 'BBD37VB98',
  customer_id: '21027149',
  account_id: '5278183',
  # client_settings: { logger: LOGGER::STDOUT }
}

service = Bing::Ads::API::V12::Services::CampaignManagement.new(options)
```

#### Getting campaigns
```ruby
account_id = 5278183
response = service.get_campaigns_by_account_id(account_id)
```

#### Getting campaigns in an account by ids
```ruby
account_id = 5278183
campaign_ids = [813721838, 813721849, 813721850]
response = service.get_campaigns_by_ids(account_id, campaign_ids)
```

#### Adding campaigns
```ruby
account_id = 5278183
campaigns = [
  {
    budget_type: Bing::Ads::API::V12.constants.campaign_management.budget_limit_type.daily_budget_standard,
    daily_budget: 2000,
    description: 'Amsterdam-based global campaign',
    name: '51 - Global - Chain - Mixed - N -en- Amsterdam - 100 - 26479',
    status: Bing::Ads::API::V12.constants.campaign_management.campaign_status.paused,
    time_zone: Bing::Ads::API::V12.constants.time_zones.amsterdam_berlin_bern_rome_stockholm_vienna
  },
  # ...
]

response = service.add_campaigns(account_id, campaigns)
```

#### Updating campaigns
```ruby
account_id = 5278183
campaigns = [
  {
    id: 813721838,
    budget_type: Bing::Ads::API::V12.constants.campaign_management.budget_limit_type.daily_budget_standard,
  },
  {
    id: 813721849,
    budget_type: Bing::Ads::API::V12.constants.campaign_management.budget_limit_type.daily_budget_standard,
  },
  # ...
]

response = service.update_campaigns(account_id, campaigns)
```

#### Deleting campaigns
```ruby
account_id = 5278183
campaign_ids_to_delete = [813721838, 813721813, 813721911]
response = service.delete_campaigns(account_id, campaign_ids_to_delete)
```

---

#### Getting ad groups in a campaign
```ruby
campaign_id = 813721838
response = service.get_ad_groups_by_campaign_id(campaign_id)
```

#### Getting ad groups in a campaign by ids
```ruby
campaign_id = 813721838
ad_group_ids = [9866221838, 9866221813, 9866221911]
response = service.get_ad_groups_by_ids(campaign_id, ad_group_ids)
```

#### Adding ad groups to a campaign
```ruby
# You can add a maximum of 1,000 ad groups in a single call.
# Each campaign can have up to 20,000 ad groups.
campaign_id = 813721838
ad_groups = [
  {
    ad_distribution: Bing::Ads::API::V12.constants.campaign_management.ad_distribution.search, # required
    ad_rotation: Bing::Ads::API::V12.constants.campaign_management.ad_rotation.optimize_for_clicks, # optional
    bidding_scheme: Bing::Ads::API::V12.constants.campaign_management.bidding_scheme.inherit_from_parent, # optional
    content_match_bid: 100, # optional
    end_date: '31/12/2020',
    status: Bing::Ads::API::V12.constants.campaign_management.ad_group_status.paused,
    language: Bing::Ads::API::V12.constants.languages.english,
    name: 'H=WHotelAmsterdam&AG=1723812002',
    native_bid_adjustment: -50, # optional (-100 to 900)
    remarketing_targeting_setting: Bing::Ads::API::V12.constants.campaign_management.remarketing_target_setting.bid_only, # optional
    search_bid: 100, # optional
    start_date: '5/7/2017',
  },
  # ...
  # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-adgroup.aspx
]

response = service.add_ad_groups(campaign_id, ad_groups)
```

#### Updating ad groups in a campaign
```ruby
# You can add a maximum of 1,000 ad groups in a single call.
# Each campaign can have up to 20,000 ad groups.
campaign_id = 813721838
ad_groups = [
  {
    id: 9866221838,
    status: Bing::Ads::API::V12.constants.campaign_management.ad_group_status.active
  },
  # ...
]

response = service.update_ad_groups(campaign_id, ad_groups)
```

#### Deleting ad groups from a campaign
```ruby
campaign_id = 813721838
ad_group_ids_to_delete = [9866221838, 9866221839, 9866221840]
response = service.delete_ad_groups(campaign_id, ad_group_ids_to_delete)
```

---

#### Getting ads in an ad group
```ruby
ad_group_id = 9866221838
response = service.get_ads_by_ad_group_id(ad_group_id)
```

#### Getting ads in an ad group by ids
```ruby
ad_group_id = 9866221838
ad_ids = [454873284248, 454873284249, 454873284250]
response = service.get_ads_by_ids(ad_group_id, ad_ids)
```

#### Adding ads to an ad group
```ruby
# You can add a maximum of 50 ads in an ad group.
ad_group_id = 9866221838
expanded_text_ads = [
  {
    type: Bing::Ads::API::V12.constants.campaign_management.ad_types.expanded_text_ad, # ExpandedTextAd
    path_1: 'Amsterdam',
    path_2: 'Hotels',
    text: 'Compare over 150 booking sites! Find guaranteed low hotel rates.',
    title_part_1: 'Hotels in Amsterdam',
    title_part_2: 'Best Deals. Book now',
    final_urls: [
      'http://www.findhotel.net/Places/Amsterdam.htm'
    ]
  },
  # ...
  # Expanded text ads
  # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-expandedtextad.aspx
  # For other ad types:
  # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-ad.aspx
]

# Returns IDs of ads added to ad group
# { ad_ids: [], partial_errors: [] }
response = service.add_ads(ad_group_id, expanded_text_ads)
```

#### Updating ads in an ad group
```ruby
ad_group_id = 9866221838
updated_expanded_text_ads = [
  {
    id: 454873284248,
    final_urls: [
      'https://www.findhotel.net/Places/Amsterdam.htm'
    ]
  },
  # ...
]

response = service.update_ads(ad_group_id, updated_expanded_text_ads)
```

#### Deleting ads from an ad group
```ruby
ad_group_id = 9866221838
ad_ids_to_delete = [454873284248, 454873284249, 454873284250]
response = service.delete_ads(ad_group_id, ad_ids_to_delete)
```

---

#### Getting keywords in an ad group
```ruby
ad_group_id = 9866221838
response = service.get_keywords_by_ad_group_id(ad_group_id)
```

#### Getting keywords in an ad group by ids
```ruby
ad_group_id = 9866221838
keyword_ids = [234873284248, 234873284249, 234873284250]
response = service.get_keywords_by_ids(ad_group_id, keyword_ids)
```

#### Adding keywords to an ad group
```ruby
ad_group_id = 9866221838
keywords = [
  {
    bidding_scheme: Bing::Ads::API::V12.constants.campaign_management.bidding_scheme.inherit_from_parent,
    bid: 5,
    # optional, ad final urls used if this is not set
    final_urls: [
      'https://www.findhotel.net/Places/Amsterdam.htm?attrs=pet-friendly'
    ],
    match_type: Bing::Ads::API::V12.constants.campaign_management.match_types.exact, # also broad, content, phrase
    status: Bing::Ads::API::V12.constants.campaign_management.keyword_statuses.active,
    text: 'Pet-friendly Hotels in Amsterdam'
  },
  # ...
  # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-keyword.aspx
  # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-addkeywords.aspx
]

# Returns IDs of keywords added to ad group
# { keyword_ids: [], partial_errors: [] }
response = service.add_keywords(ad_group_id, keywords)
```

#### Updating keywords in an ad group
```ruby
ad_group_id = 9866221838
updated_keywords = [
  {
    id: 234873284248,
    # updated attributes
  },
  # ...
]

response = service.update_keywords(ad_group_id, updated_keywords)
```

#### Deleting keywords from an ad group
```ruby
ad_group_id = 9866221838
keyword_ids_to_delete = [234873284248, 234873284249, 234873284250]
response = service.delete_keywords(ad_group_id, keyword_ids_to_delete)
```

### Bulk Service
#### Initialization
```ruby
# Authentication token is not supported in sandbox, use `username` and `password` instead
# https://msdn.microsoft.com/en-us/library/dn277356.aspx

options = {
  environment: :sandbox,
  authentication_token: '39b290146bea6ce975c37cfc23',
  developer_token: 'BBD37VB98',
  customer_id: '21027149',
  account_id: '5278183',
  # client_settings: { logger: LOGGER::STDOUT }
}

service = Bing::Ads::API::V12::Services::Bulk.new(options)
```

#### Submit a request for a URL where a bulk upload file may be posted.
```ruby
response = service.get_bulk_upload_url

# @return
# {
#   request_id: 4981237213
#   upload_url: '-'
# }
```

#### Get the status and completion percentage of a bulk upload request.
```ruby
response = service.get_bulk_upload_status(request_id)

# @return
# {
#   errors: [],
#   percent_complete: 100,
#   request_status: '-',
#   result_file_url: '-'
# }
```

### Reporting Service

#### Initialization
```ruby
# Authentication token is not supported in sandbox, use `username` and `password` instead
# https://msdn.microsoft.com/en-us/library/dn277356.aspx

options = {
  environment: :sandbox,
  authentication_token: '39b290146bea6ce975c37cfc23',
  developer_token: 'BBD37VB98',
  customer_id: '21027149',
  # client_settings: { logger: LOGGER::STDOUT }
}

service = Bing::Ads::API::V12::Services::Reporting.new(options)
```

#### Submit Generate Report
To get reports from Bing, you must first submit a report generation request.

The method `submit_generate_report` receive two params as input, first the `report_type` and then a hash with the report options.

Example:

```ruby
response = service.submit_generate_report(:keyword_performance, {
  exclude_column_headers: false,
  exclude_report_footer: false,
  exclude_report_header: false,
  language: 'English',
  format: 'Tsv',
  report_name: 'keyword_performance_report',
  return_only_complete_data: false,
  aggregation: 'Daily',
  columns: [:destination_url, :average_cpc],
  from_date: '2017-10-23',
  to_date: '2017-10-25'
  account_ids: [144012349, 224002158]
})
```

The required options depend on the report type you are using.

Response example:

```ruby
{:report_request_id=>"30000000999745662", :@xmlns=>"https://bingads.microsoft.com/Reporting/v12"}
```

#### Poll Generate Report

To retrieve the report generated you have a few options:

You can check if the report is ready and then get the url:
```ruby
service.report_url(report_request_id) if service.report_ready?(report_request_id)
```

Or you can download the body of the report when it's ready. (and then write to a file for example)
```ruby
service.report_body(report_request_id) if service.report_ready?(report_request_id)
```

You can also get the entire poll_generate_reportl report object:
```ruby
service.poll_generate_report(report_request_id)
```

### Errors raised
* `Bing::Ads::API::Errors::AuthenticationParamsMissing` No username/password or authentication_token.
* `Bing::Ads::API::Errors::AuthenticationTokenExpired` Authentication token needs to be refreshed.
* `Bing::Ads::API::Errors::LimitError` An API limit has been exceeded on a specific request. Check message for details.
* `Bing::Ads::API::Errors::DownloadError` Error when downloading a report body.

## Development
After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.
To install this gem onto your local machine, run `bundle exec rake install`.

## Tests
Endpoints were manually tested but although RSpec is installed as a test framework, there are no tests written yet.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/FindHotel/bing-ads.
