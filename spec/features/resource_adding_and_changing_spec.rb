RSpec.feature "Resource adding and changing" do
  include_context "as a logged-in editor user"

  let!(:context) { create(:context,organization: user_organization) }

  let(:resource_attributes) do
    attributes_for(:resource).tap(&:symbolize_keys!).merge(title: title)
  end

  scenario "succeeds" do
    click_link "Resources"

    click_first_link("New Resource")

    select(context.title,from: "Context",:match => :first)

    fill_in "Identifier",    with: resource_attributes[:identifier]
    fill_in "Title",         with: resource_attributes[:title]
    fill_in "Canonical ID",  with: resource_attributes[:canonical_id]

    select(resource_attributes[:resource_type],from: 'Type')

    expect {
      click_button('Save')
    }.to change(Resource,:count).
      from(0).to(1)

    resource = Resource.find_by!(identifier: resource_attributes[:identifier])

    expect(page.current_path).to eq(organization_resource_path(user_organization,resource))
    expect(page).to have_content(resource.title)
  end
end