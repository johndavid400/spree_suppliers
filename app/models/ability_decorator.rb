class AbilityDecorator
  include CanCan::Ability
  def initialize(user)
    if user.has_role? "vendor"
      can :manage, Product
      can :manage, Variant
      can :manage, OptionType
      can :manage, Property
      can :manage, Prototype
      can :manage, ProductGroup
      can :manage, ProductProperty
      can :manage, Taxon
      can :manage, Pickup
      can :manage, PickupLocation
      can :manage, Order
      can :manage, Supplier
    end
  end
end
