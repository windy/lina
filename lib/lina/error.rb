module Lina
  class Error < RuntimeError #:nodoc:
  end

  class ParamsCheckError < Error #:nodoc:
  end

  class ReturnCheckError < Error #:nodoc:
  end

  class ApiSpecError < Error #:nodoc:
  end
end
