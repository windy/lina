# lina config file
Lina.setup do |config|
  #是否自动生成 views
  #config.generate_views = true

  #是否开启入口参数校验
  #config.params_check = true

  #入口参数校验时使用的 json schema 版本, 更多: http://tools.ietf.org/html/draft-zyp-json-schema-04
  #config.params_json_schema_version = :v4


  #是否开启返回值参数校验
  #config.return_check = true

  #返回值校验时使用的 json schema 版本, 更多: http://tools.ietf.org/html/draft-zyp-json-schema-04
  #config.return_json_schema_version = :v4
end
