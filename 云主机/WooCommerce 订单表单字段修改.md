WooCommerce 订单表单字段修改

http://devework.com/woocommerce-custom-override-checkout-fields.html

将代码段添加到主题文件目录下的 function.php中

```
// Form filter
add_filter( 'woocommerce_checkout_fields' , 'custom_override_checkout_fields' );
function custom_override_checkout_fields( $fields ) {
    //unset($fields['order']['order_comments']);
    //unset( $fields['billing']['billing_country'] );
    //unset( $fields['billing']['billing_first_name'] );
    //unset( $fields['billing']['billing_last_name'] );
    unset( $fields['billing']['billing_company'] );
    //unset( $fields['billing']['billing_address_1'] );
    //unset( $fields['billing']['billing_address_2'] );
    //unset( $fields['billing']['billing_city'] );
    //unset( $fields['billing']['billing_state'] );
    //unset( $fields['billing']['billing_postcode'] );
    //unset($fields['billing']['billing_email']);
    //unset( $fields['billing']['billing_phone'] );
	$fields['order']['order_comments']['label'] = __('留言', 'woocommerce');
	$fields['order']['order_comments']['placeholder'] = _x('请在这里留言备注','placeholder','woocommerce');
    return $fields;
}
```
需求二：设置表单元素的一些显示样式

上面的小标题实在是太难表达Jeff 的意思了，下面直接上例子+代码。例如：默认的话，电子邮件（email）的表单是非常短的一个输入框，如果要变长一点，并不是说通过css来的（因为官方已经统一化这些控件，如果一改牵一发动全身）。好在官方对于text表单定义了不同的类（class），具体而言，你需要查看官方文档，然后捏代码应该是这样的：

```
// 将默认的邮箱输入框重置为最大
add_filter( 'woocommerce_checkout_fields' , 'custom_override_checkout_fields' );
function custom_override_checkout_fields( $fields ) {
$fields['billing']['billing_email']['class'] = array('form-row-wide');
return $fields;
}
```

需求三：添加自定义的表单元素

比如说我想定义一个text的输入框，就可以用下面的代码：

```
add_filter( 'woocommerce_checkout_fields' , 'custom_override_checkout_fields' );
function custom_override_checkout_fields( $fields ) {
$fields['billing']['billing_domain_one'] = array(
        'label'         => __('域名授权1', 'woocommerce'),//名称
        'placeholder'   => _x('区分有无www，不含http://', 'placeholder', 'woocommerce'),//占位文字
        'required'      => true,//是否必填项
        'class'         => array('form-row-wide'),//类
        'clear'         => true//是否清除浮动
     );
  $fields['billing']['billing_domain_two'] = array(
        'label'         => __('域名授权2', 'woocommerce'),
        'placeholder'   => _x('区分有无www，不含http://', 'placeholder', 'woocommerce'),
        'required'      => true,
        'class'         => array('form-row-wide'),
        'clear'         => true
     );
return $fields;
}
```
