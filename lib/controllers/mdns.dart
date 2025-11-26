import "package:get/get.dart";
import "package:shared_preferences/shared_preferences.dart";
import 'package:multicast_dns/multicast_dns.dart';
/*

Future<void> main() async {
  // Parse the command line arguments.

  const String name = '_dartobservatory._tcp.local';
  final MDnsClient client = MDnsClient();
  // Start the client with default options.
  await client.start();

  // Get the PTR record for the service.
  await for (final PtrResourceRecord ptr in client
      .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
    // Use the domainName from the PTR record to get the SRV record,
    // which will have the port and local hostname.
    // Note that duplicate messages may come through, especially if any
    // other mDNS queries are running elsewhere on the machine.
    await for (final SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
        ResourceRecordQuery.service(ptr.domainName))) {
      // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
      final String bundleId =
          ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
      print('Dart observatory instance found at '
          '${srv.target}:${srv.port} for "$bundleId".');
    }
  }
  client.stop();

  print('Done.');
}
*/
class MdnsDiscoveryController extends GetxController {
  final MDnsClient client = MDnsClient();
  RxList<OrchestratorInstance> found = <OrchestratorInstance>[].obs;
  RxBool ready = false.obs;
  bool searching = false;
  void findServices({String name = "iot-orchestrator"}) async {
    searching = true;
    await for (final PtrResourceRecord ptr in client.lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer("_$name._tcp.local"))) {
      // Use the domainName from the PTR record to get the SRV record,
      // which will have the port and local hostname.
      // Note that duplicate messages may come through, especially if any
      // other mDNS queries are running elsewhere on the machine.
      await for (final SrvResourceRecord srv in
        client.lookup<SrvResourceRecord>(ResourceRecordQuery.service(ptr.domainName))
      ) {
        // Domain name will be something like "io.flutter.example@some-iphone.local._dartobservatory._tcp.local"
        final String bundleId = ptr.domainName; //.substring(0, ptr.domainName.indexOf('@'));
        print('Dart observatory instance found at '
          '${srv.target}:${srv.port} for "$bundleId".');
        
        // Now we look up the IP because it gives us the hostname :rolling-eyes:
        await for (final IPAddressResourceRecord ipRec in
          client.lookup<IPAddressResourceRecord>(ResourceRecordQuery.addressIPv4(srv.target))
        ) {
          String ip = ipRec.address.address;
          print("Found ip as ${ip} for ${srv.target}!");

          var obj = OrchestratorInstance(ip: ip, port: srv.port, name: srv.target.split(".")[0]);
          var foundList = found.value;
          foundList.add(obj);
          found.value = foundList;
        }
      }
    }
    searching = false;
  }
  
  Future init() async {
    await client.start();
    ready.value = true;
  }
  @override
  void onInit() async {
    super.onInit();
    init();
  }
}
class OrchestratorInstance {
  String ip = "";
  int port = -1; 
  String name = "";
  OrchestratorInstance({required String ip, required int port, required String name}){
    this.ip = ip;
    this.port = port;
    this.name = name;
  }
}
