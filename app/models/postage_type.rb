class PostageType < ActiveHash::Base
  self.data = [
    {id: 1, postage_type: '普通郵便'},
    {id: 2, postage_type: 'ゆうメール'},
    {id: 3, postage_type: 'レターパック'},
    {id: 4, postage_type: 'ゆうパック'},
    {id: 5, postage_type: 'クロネコヤマト'},
    {id: 6, postage_type: 'クリックパケット'},
    {id: 7, postage_type: 'ゆうパケット'}
  ]
end