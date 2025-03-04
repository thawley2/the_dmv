require 'spec_helper'

RSpec.describe VehicleFactory do
  it 'exists' do
    factory = VehicleFactory.new

    expect(factory).to be_instance_of(VehicleFactory)
  end

  it 'can create vehicles with retrieved data from an API' do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    factory.create_vehicles(wa_ev_registrations)

    expect(factory.vehicle_storage[0]).to be_instance_of(Vehicle)
    expect(factory.vehicle_storage.length).to eq(1000)
  end

  it 'has the correct attributes' do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    factory.create_vehicles(wa_ev_registrations)

    expect(factory.vehicle_storage[0].vin).to eq("JTMEB3FV7M")
    expect(factory.vehicle_storage[0].year).to eq("2021")
    expect(factory.vehicle_storage[0].make).to eq("TOYOTA")
    expect(factory.vehicle_storage[0].model).to eq("RAV4 Prime")
  end

  it 'can find the most popular make of vehicle' do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    factory.create_vehicles(wa_ev_registrations)

    expect(factory.find_most_popular_make).to eq('TESLA')
    expect(factory.find_most_popular_model).to eq('Model 3')
    expect(factory.most_popular_make_model).to eq('TESLA, Model 3')
  end

  it 'can count the number of vehicles for a model year' do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations
    factory.create_vehicles(wa_ev_registrations)

    expect(factory.number_by_model_year('Model S', '2020')).to eq(4)
    expect(factory.number_by_model_year('Prius Prime', '2017')).to eq(3)
  end

  it 'can display the county with the most registered vehicles' do
    factory = VehicleFactory.new
    wa_ev_registrations = DmvDataService.new.wa_ev_registrations

    expect(factory.county_with_most_vehicles(wa_ev_registrations)).to eq('King')
  end
end