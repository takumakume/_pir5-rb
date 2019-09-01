require 'test_helper'

class DomainsTest < Minitest::Test
  def test_create_domain
    VCR.use_cassette('test_create_domain') do
      Pir5.create_domain('create-domain.com')
      assert_equal 201, Pir5.last_response.status
    end
  end

  def test_create_domain_duplicate_entry
    VCR.use_cassette('test_create_domain_duplicate_entry') do
      Pir5.create_domain('create-domain-duplicate-entry.com')

      assert_raises Pir5::InternalServerError do
        Pir5.create_domain('create-domain-duplicate-entry.com')
      end
    end
  end

  def test_domains
    VCR.use_cassette('test_domains') do
      Pir5.create_domain('domains.com')

      ret = Pir5.domains({ name: 'domains.com' })
      assert_equal 200, Pir5.last_response.status
      assert_equal 1, ret.size
      assert_equal 'domains.com', ret.first['name']
    end
  end

  def test_domains_not_found
    VCR.use_cassette('test_domains_not_found') do
      assert_raises Pir5::NotFound do
        Pir5.domains({ name: 'domains-not-found.com' })
      end
    end
  end

  def test_domain_by_name
    VCR.use_cassette('test_domain_by_name') do
      Pir5.create_domain('domain-by-name.com')

      ret = Pir5.domain_by_name('domain-by-name.com')
      assert_equal 200, Pir5.last_response.status
      assert_equal 'domain-by-name.com', ret['name']
    end
  end

  def test_domain_by_name_not_found
    VCR.use_cassette('test_domain_by_name_not_found') do
      assert_raises Pir5::NotFound do
        Pir5.domain_by_name('domain-by-name-not-found.com')
      end
    end
  end

  def test_domain_by_id
    VCR.use_cassette('test_domain_by_id') do
      Pir5.create_domain('domain-by-id.com')

      ret = Pir5.domain_by_id(Pir5.domain_by_name('domain-by-id.com')['id'])
      assert_equal 200, Pir5.last_response.status
      assert_equal 'domain-by-id.com', ret['name']
    end
  end

  def test_domain_by_id_not_found
    VCR.use_cassette('test_domain_by_id_not_found') do
      assert_raises Pir5::NotFound do
        Pir5.domain_by_id('domain-by-id-not-found.com')
      end
    end
  end

  # def test_update_domain
  #   # TODO: サーバ側でhttp authを有効にしてallowedDomainを返せるようにする
  #   VCR.use_cassette('test_update_domain') do
  #     Pir5.create_domain('update-domain1.com')
  #     d = Pir5.domain_by_name('update-domain1.com')
  #     d['name'] = 'update-domain2.com'
  #
  #     Pir5.update_domain('update-domain1.com', d)
  #     assert_equal 200, Pir5.last_response.status
  #   end
  # end

  # def test_delete_domain
  #   # TODO: サーバ側でhttp authを有効にしてallowedDomainを返せるようにする
  #   VCR.use_cassette('test_update_domain') do
  #     Pir5.create_domain('delete-domain.com')
  #
  #     Pir5.delete_domain('delete-domain.com')
  #     assert_equal 200, Pir5.last_response.status
  #   end
  # end
end
