module Pir5
  class Client
    module Domains
      def domains(params = {})
        get("v1/domains", params)
      end

      def domain_by_name(name)
        get("v1/domains", { name: name }).first
      end

      def domain_by_id(id)
        get("v1/domains", { id: id }).first
      end

      def create_domain(name)
        post("v1/domains", { name: name })
      end

      def update_domain(name, params = {})
        put("v1/domains/#{name}", params)
      end

      def delete_domain(name)
        delete("v1/domains/#{name}")
      end
    end
  end
end
