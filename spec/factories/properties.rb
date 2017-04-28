FactoryGirl.define do
  factory :property do
    mls_server
    street_address "123 Sample Street"
    state "CA"
    city "Santa Barbara"
    area "Montecito"
    public_remarks "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla fringilla sodales metus, scelerisque fringilla diam congue ut. Aliquam ut lorem libero, sit amet congue lacus. Proin mauris sem, iaculis in rhoncus at, mollis et nisl. Aenean et elit at diam congue dignissim. Fusce pulvinar elit ante, eu pretium ligula. Mauris non blandit metus. Nunc pharetra lacus id diam tempus eget ultrices libero viverra. Mauris consequat, orci in consequat accumsan, diam justo fringilla orci, vitae pulvinar risus augue et orci. Quisque tortor quam, placerat eget pellentesque eget, sagittis vitae ante. Phasellus condimentum faucibus vehicula. Vivamus faucibus sapien eu est egestas consequat. Vivamus nec erat id tellus vulputate mollis vitae mollis enim. Fusce elit leo, sagittis eu egestas vel, ultrices sit amet justo. Nam volutpat condimentum augue id aliquet. Maecenas malesuada rutrum vestibulum. Quisque quis rhoncus mauris."
    list_price 1000000
    photos ["http://cdn.resize.sparkplatform.com/sbr/1024x768/true/20170413212753486332000000-o.jpg"]
    internal_mls_id { SecureRandom.hex(16) }
  end
end
