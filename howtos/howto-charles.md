# How to Setup Charles

Charles is a proxy service that let's you intercept and see traffic on your mobile device. Useful for testing.

## Setup Charles

[Download](https://www.charlesproxy.com/download/latest-release)/Install/Run Charles

Turn off macOS proxying

- Proxy > macOS Proxy (uncheck)

Get your local IP Address

- Help > Local IP Address

## Setup iOS Device

Enter local IP address

 - Settings > Wifi > (i) information > HTTP Proxy > Manual
 - server / port (8888)
 
 * Note: Your device must be on the same network as your computer!!!

Install Charles Proxy Certificate on Phone by browsing to

 - http://chls.pro/ssl

Trust Charles Proxy Certificate

 - Settings > General > About > Certificate Trust Settings

Enable Proxy for this host

 - In Charles add the hosts you want to decrypt
 - Proxy > SSL Proxying Settings > Add (i.e. iphone-id.apple.com)

### Links

- [Ray Wenderlich Tutorial](https://www.raywenderlich.com/641-charles-proxy-tutorial-for-ios)
- [StackOverflow](https://stackoverflow.com/questions/15768143/ios-app-ssl-handshake-failed)
