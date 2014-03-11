From: Santiago Font <sfont@teldat.com>
Subject: Re: LTTng-ust 2.4.0-rc2: no events when tracing busybox
Date: Tue, 11 Mar 2014 23:12:10 +0100
Message-ID: <531F8A3A.4070102__21760.048197075$1394576682$gmane$org@teldat.com>
References: <531F55BB.6030203@teldat.com>
	<118991123.277.1394565002713.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090102060103050408090805"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.teldat.com ([195.53.62.69])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sfont@teldat.com>) id 1WNUuI-000862-5f
	for lttng-dev@lists.lttng.org; Tue, 11 Mar 2014 18:12:25 -0400
In-Reply-To: <118991123.277.1394565002713.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--------------090102060103050408090805
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

     As I mentioned, I'm building OpenWRT, therefore, part of the 
integration of LTTng into Busybox is managed at OpenWRT package level, 
but it is also true that you only need to add the dependency on 
lttng-ust (Makefile.patch and Makefile, where you can see the Busybox 
version being used). Adding the dependency directly into Busybox build 
system should be easy too.
     Regarding the patch to add tracepoints to Busybox codebase, it is 
an addition to the patches applied by OpenWRT (new patch 
904-telnetd_lttng_events.patch), but no black magic there neither:
           - add a couple of new files for LTTng tracepoints 
definition/declaration: networking/telnetd_lttng_events.c and 
networking/telnetd_lttng_events.h
           - add tracepoints calls to telnetd.c
           - add tracepoint provider to telnetd built: (Kbuild.src: 
lib-$(CONFIG_TELNETD) += telnetd.o telnetd_lttng_events.o)

     And that's all. If this is not the info you are asking for, let me 
know.
     Thanks,

                  Santi

On 11/03/14 20:10, Mathieu Desnoyers wrote:
> ----- Original Message -----
>> From: "Santiago Font" <sfont@teldat.com>
>> To: lttng-dev@lists.lttng.org
>> Sent: Tuesday, March 11, 2014 2:28:11 PM
>> Subject: [lttng-dev]   LTTng-ust 2.4.0-rc2: no events when tracing busybox
>>
>> Hi,
>>
>>       I have an embedded scenario (openwrt over Freescale) working with
>> LTTng:
>>
>>           lttng create TEST
>>           lttng enable-channel MYCHAN -u --buffers-uid --subbuf-size 64k
>>           lttng add-context -u -t procname -c MYCHAN
>>           lttng enable-event -u "*" -c MYCHAN
>>           lttng start
>>           /usr/sbin/sample &
>>           lttng stop
>>           lttng view
>>
>>               - Several ust_baddr_statedump:soinfo events
>>               - An example of the events I defined
>>              (See below for details: dump_1)
>>
>>       So far, so good.
>>
>>       Now, I'm trying to add my events to busybox to trace telnetd (very
>> same provider .c file and event definition .h file, changing only the
>> provider name).
>>       When I follow exactly the same steps but changing "/usr/sbin/sample
>> &" for "/usr/sbin/telnetd -F &", I get the ust_baddr_statedump:soinfo
>> events, but none of my events (see dump_2)
>>       I have tried with/without TRACEPOINT_PROBE_DYNAMIC_LINKAGE,
>> with/without LD_PRELOAD=liblttng-ust-fork.so, but not success.
>>       Taking a look to the symbols inside the binary (dump 3), all LTTng
>> stuff seems to be there.
>>
>>       LTTng (modules, tools, ust): 2.4.0
>>
>>       Any idea?
> Could you share with us your patch that adds your specific tracepoints
> into the busybox codebase, along with the specific links/version info
> needed for us to see how it integrate into the busybox build system ?
>
> Thanks,
>
> Mathieu
>
>>       Thank you,
>>
>>                 Santi
>>
>>
>>
>> ------- dump_1 ------------------
>>
>> [00:05:04.281094007] (+10.405305121) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x10000000, sopath =
>> "/usr/sbin/sample", size = 9176, mtime = 1394554355 }
>> [00:05:04.281173138] (+0.000079131) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48018000, sopath =
>> "/lib/libdl-0.9.33.2.so", size = 12436, mtime = 1394229945 }
>> [00:05:04.281214310] (+0.000041172) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4802C000, sopath =
>> "/usr/lib/liblttng-ust.so.0.0.0", size = 224696, mtime = 1394554355 }
>> [00:05:04.281239239] (+0.000024929) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48074000, sopath =
>> "/lib/libgcc_s.so.1", size = 88200, mtime = 1394229944 }
>> [00:05:04.281271259] (+0.000032020) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4809A000, sopath =
>> "/lib/libuClibc-0.9.33.2.so", size = 326616, mtime = 1394229945 }
>> [00:05:04.281303562] (+0.000032303) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48000000, sopath =
>> "/lib/ld-uClibc-0.9.33.2.so", size = 29052, mtime = 1394229945 }
>> [00:05:04.281344714] (+0.000041152) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x480FF000, sopath =
>> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 25276, mtime =
>> 1394554355 }
>> [00:05:04.281376996] (+0.000032282) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4811E000, sopath =
>> "/lib/librt-0.9.33.2.so", size = 12404, mtime = 1394229945 }
>> [00:05:04.281416532] (+0.000039536) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48132000, sopath =
>> "/usr/lib/liburcu-bp.so.1.0.0", size = 15388, mtime = 1394548454 }
>> [00:05:04.281456411] (+0.000039879) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x48146000, sopath =
>> "/usr/lib/liburcu-cds.so.1.0.0", size = 18216, mtime = 1394548454 }
>> [00:05:04.281489138] (+0.000032727) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4815B000, sopath =
>> "/lib/libpthread-0.9.33.2.so", size = 70104, mtime = 1394229945 }
>> [00:05:04.281529501] (+0.000040363) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "sample" }, { baddr = 0x4817F000, sopath =
>> "/usr/lib/liburcu-common.so.1.0.0", size = 3188, mtime = 1394548454 }
>> [00:05:04.282903966] (+0.001374465) OpenWrt busybox_telnetd2:info: {
>> cpu_id = 0 }, { procname = "sample" }, { msg = "Hello World" }
>> [00:05:04.282922512] (+0.000018546) OpenWrt busybox_telnetd2:session: {
>> cpu_id = 0 }, { procname = "sample" }, { msg = "Session", client =
>> "10.0.2.5", server = "10.0.2.4", session_pid = 0 }
>> [00:05:04.282929643] (+0.000007131) OpenWrt busybox_telnetd2:err: {
>> cpu_id = 0 }, { procname = "sample" }, { call = "arg1", msg = "arg2",
>> errno_val = 0 }
>>
>> ------- dump_2 ------------------
>> [00:14:16.375740554] (+11.778441605) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x10000000, sopath =
>> "/bin/busybox", size = 438834, mtime = 1394559555 }
>> [00:14:16.375818817] (+0.000078263) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48018000, sopath =
>> "/lib/libcrypt-0.9.33.2.so", size = 20724, mtime = 1394229945 }
>> [00:14:16.375852150] (+0.000033333) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x4803F000, sopath =
>> "/lib/libdl-0.9.33.2.so", size = 12436, mtime = 1394229945 }
>> [00:14:16.375892474] (+0.000040324) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48053000, sopath =
>> "/usr/lib/liblttng-ust.so.0.0.0", size = 224696, mtime = 1394554355 }
>> [00:14:16.375941827] (+0.000049353) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x4809B000, sopath =
>> "/lib/libm-0.9.33.2.so", size = 61540, mtime = 1394229945 }
>> [00:14:16.375967524] (+0.000025697) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x480BB000, sopath =
>> "/lib/libgcc_s.so.1", size = 88200, mtime = 1394229944 }
>> [00:14:16.375999484] (+0.000031960) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x480E1000, sopath =
>> "/lib/libuClibc-0.9.33.2.so", size = 326616, mtime = 1394229945 }
>> [00:14:16.376031585] (+0.000032101) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48000000, sopath =
>> "/lib/ld-uClibc-0.9.33.2.so", size = 29052, mtime = 1394229945 }
>> [00:14:16.376072696] (+0.000041111) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48146000, sopath =
>> "/usr/lib/liblttng-ust-tracepoint.so.0.0.0", size = 25276, mtime =
>> 1394554355 }
>> [00:14:16.376104938] (+0.000032242) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48165000, sopath =
>> "/lib/librt-0.9.33.2.so", size = 12404, mtime = 1394229945 }
>> [00:14:16.376144635] (+0.000039697) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x48179000, sopath =
>> "/usr/lib/liburcu-bp.so.1.0.0", size = 15388, mtime = 1394548454 }
>> [00:14:16.376184373] (+0.000039738) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x4818D000, sopath =
>> "/usr/lib/liburcu-cds.so.1.0.0", size = 18216, mtime = 1394548454 }
>> [00:14:16.376217363] (+0.000032990) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x481A2000, sopath =
>> "/lib/libpthread-0.9.33.2.so", size = 70104, mtime = 1394229945 }
>> [00:14:16.376257908] (+0.000040545) OpenWrt ust_baddr_statedump:soinfo:
>> { cpu_id = 0 }, { procname = "telnetd" }, { baddr = 0x481C6000, sopath =
>> "/usr/lib/liburcu-common.so.1.0.0", size = 3188, mtime = 1394548454 }
>>
>> ----- dump 3 ------------
>> nm ipkg-install/bin/busybox | grep 'tracepoint\|busybox_telnetd\|lttng'
>>
>> 1007b124 d __event_desc___busybox_telnetd
>> 1005f7d0 R __event_desc___busybox_telnetd_err
>> 1005fee4 R __event_desc___busybox_telnetd_info
>> 1005fea4 R __event_desc___busybox_telnetd_session
>> 1005f998 r __event_fields___busybox_telnetd___err
>> 1005f868 r __event_fields___busybox_telnetd___info
>> 1005ff24 r __event_fields___busybox_telnetd___session
>> 10016624 t __event_probe__busybox_telnetd___err
>> 100164a4 t __event_probe__busybox_telnetd___info
>> 10016878 t __event_probe__busybox_telnetd___session
>> 1007b134 d _format___busybox_telnetd___err
>> 1007b130 d _format___busybox_telnetd___info
>> 1007b138 d _format___busybox_telnetd___session
>>            w _loglevel___busybox_telnetd___err
>>            w _loglevel___busybox_telnetd___info
>>            w _loglevel___busybox_telnetd___session
>> 10016ca0 t __lttng_events_exit__busybox_telnetd
>> 10016c3c t __lttng_events_init__busybox_telnetd
>>            U lttng_probe_register
>>            U lttng_probe_unregister
>>            w _model_emf_uri___busybox_telnetd___err
>>            w _model_emf_uri___busybox_telnetd___info
>>            w _model_emf_uri___busybox_telnetd___session
>> 1007b13c d __probe_desc___busybox_telnetd
>> 1007c228 b __probe_register_refcount___busybox_telnetd
>> 1007b1ec A __start___tracepoints_ptrs
>> 1007b1f8 A __stop___tracepoints_ptrs
>> 1005fe70 R __tp_event_signature___busybox_telnetd___err
>> 1005f858 R __tp_event_signature___busybox_telnetd___info
>> 1005f810 R __tp_event_signature___busybox_telnetd___session
>> 1006ac80 r __tp_strtab_busybox_telnetd___err
>> 1006ac94 r __tp_strtab_busybox_telnetd___info
>> 1006ac68 r __tp_strtab_busybox_telnetd___session
>> 1007b180 D __tracepoint_busybox_telnetd___err
>> 1007b1c8 D __tracepoint_busybox_telnetd___info
>> 1007b1a4 D __tracepoint_busybox_telnetd___session
>> 1007c210 V tracepoint_dlopen
>> 100155e8 t __tracepoint__init_urcu_sym
>> 1007b250 S __tracepoint_provider_busybox_telnetd
>> 1007b1f0 d __tracepoint_ptr_busybox_telnetd___err
>> 1007b1f4 d __tracepoint_ptr_busybox_telnetd___info
>> 1007b1ec d __tracepoint_ptr_busybox_telnetd___session
>> 1007b248 V __tracepoint_ptrs_registered
>> 1007b24c V __tracepoint_registered
>> 10015708 t __tracepoints__destroy
>> 10016ba4 t __tracepoints__destroy
>> 10015684 t __tracepoints__init
>> 10016ac4 t __tracepoints__init
>> 10015868 t __tracepoints__ptrs_destroy
>> 100157a0 t __tracepoints__ptrs_init
>>
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>>


--------------090102060103050408090805
Content-Type: text/x-patch; name="Makefile.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Makefile.patch"

--- a/package/utils/busybox/Makefile
+++ b/package/utils/busybox/Makefile
@@ -46,7 +46,7 @@ define Package/busybox
   MAINTAINER:=Nicolas Thill <nico@openwrt.org>
   TITLE:=Core utilities for embedded Linux
   URL:=http://busybox.net/
-  DEPENDS:=+BUSYBOX_CONFIG_FEATURE_HAVE_RPC:librpc
+  DEPENDS:=+BUSYBOX_CONFIG_FEATURE_HAVE_RPC:librpc +lttng-ust
   MENU:=1
 endef
 
@@ -76,12 +76,18 @@ ifdef CONFIG_GCC_VERSION_LLVM
 endif
 
 LDLIBS:=m crypt
+
 ifdef CONFIG_BUSYBOX_CONFIG_FEATURE_HAVE_RPC
   TARGET_CFLAGS += -I$(STAGING_DIR)/usr/include
   export LDFLAGS=$(TARGET_LDFLAGS)
   LDLIBS += rpc
 endif
 
+ifdef CONFIG_PACKAGE_lttng-ust
+  TARGET_CFLAGS += -I.
+  LDLIBS += lttng-ust dl
+endif
+
 define Build/Compile
 	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
 		CC="$(TARGET_CC)" \

--------------090102060103050408090805
Content-Type: text/plain; charset="UTF-8"; name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Makefile"

IyAKIyBDb3B5cmlnaHQgKEMpIDIwMDYtMjAxMyBPcGVuV3J0Lm9yZwojCiMgVGhpcyBpcyBm
cmVlIHNvZnR3YXJlLCBsaWNlbnNlZCB1bmRlciB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdjIuCiMgU2VlIC9MSUNFTlNFIGZvciBtb3JlIGluZm9ybWF0aW9uLgojCgppbmNs
dWRlICQoVE9QRElSKS9ydWxlcy5tawoKUEtHX05BTUU6PWJ1c3lib3gKUEtHX1ZFUlNJT046
PTEuMTkuNApQS0dfUkVMRUFTRTo9NwpQS0dfRkxBR1M6PWVzc2VudGlhbAoKUEtHX1NPVVJD
RTo9JChQS0dfTkFNRSktJChQS0dfVkVSU0lPTikudGFyLmJ6MgpQS0dfU09VUkNFX1VSTDo9
aHR0cDovL3d3dy5idXN5Ym94Lm5ldC9kb3dubG9hZHMgXAoJCWh0dHA6Ly9kaXN0ZmlsZXMu
Z2VudG9vLm9yZy9kaXN0ZmlsZXMvClBLR19NRDVTVU06PTljMGNhZTVhMDM3OTIyOGU3YjU1
ZTViMjk1MjhkZjhlCgpQS0dfQlVJTERfREVQRU5EUzo9QlVTWUJPWF9DT05GSUdfRkVBVFVS
RV9IQVZFX1JQQzpsaWJycGMKUEtHX0JVSUxEX1BBUkFMTEVMOj0xCgpQS0dfTElDRU5TRTo9
R1BMdjIgQlNELTRjClBLR19MSUNFTlNFX0ZJTEVTOj1MSUNFTlNFIGFyY2hpdmFsL2xpYmFy
Y2hpdmUvYnovTElDRU5TRQoKaW5jbHVkZSAkKElOQ0xVREVfRElSKS9wYWNrYWdlLm1rCgpp
ZmVxICgkKERVTVApLCkKICBTVEFNUF9DT05GSUdVUkVEOj0kKHN0cmlwICQoU1RBTVBfQ09O
RklHVVJFRCkpXyQoc2hlbGwgJChTSF9GVU5DKSBncmVwICdeQ09ORklHX0JVU1lCT1hfJyAk
KFRPUERJUikvLmNvbmZpZyB8IG1kNXMpCmVuZGlmCgppZm5lcSAoJChmaW5kc3RyaW5nIGMs
JChPUEVOV1JUX1ZFUkJPU0UpKSwpCiAgQkJfTUFLRV9WRVJCT1NFIDo9IFY9MQplbHNlCiAg
QkJfTUFLRV9WRVJCT1NFIDo9CmVuZGlmCgppbml0LXkgOj0KaW5pdC0kKENPTkZJR19CVVNZ
Qk9YX0NPTkZJR19DUk9ORCkgKz0gY3Jvbgppbml0LSQoQ09ORklHX0JVU1lCT1hfQ09ORklH
X05UUEQpICs9IHN5c250cGQKaW5pdC0kKENPTkZJR19CVVNZQk9YX0NPTkZJR19URUxORVRE
KSArPSB0ZWxuZXQKCmRlZmluZSBQYWNrYWdlL2J1c3lib3gKICBTRUNUSU9OOj1iYXNlCiAg
Q0FURUdPUlk6PUJhc2Ugc3lzdGVtCiAgTUFJTlRBSU5FUjo9Tmljb2xhcyBUaGlsbCA8bmlj
b0BvcGVud3J0Lm9yZz4KICBUSVRMRTo9Q29yZSB1dGlsaXRpZXMgZm9yIGVtYmVkZGVkIExp
bnV4CiAgVVJMOj1odHRwOi8vYnVzeWJveC5uZXQvCiAgREVQRU5EUzo9K0JVU1lCT1hfQ09O
RklHX0ZFQVRVUkVfSEFWRV9SUEM6bGlicnBjICtsdHRuZy11c3QKICBNRU5VOj0xCmVuZGVm
CgpkZWZpbmUgUGFja2FnZS9idXN5Ym94L2Rlc2NyaXB0aW9uCiBUaGUgU3dpc3MgQXJteSBL
bmlmZSBvZiBlbWJlZGRlZCBMaW51eC4KIEl0IHNsaWNlcywgaXQgZGljZXMsIGl0IG1ha2Vz
IEp1bGlhbiBGcmllcy4KZW5kZWYKCmRlZmluZSBQYWNrYWdlL2J1c3lib3gvY29uZmlnCglz
b3VyY2UgIiQoU09VUkNFKS9Db25maWcuaW4iCmVuZGVmCgpkZWZpbmUgQnVpbGQvQ29uZmln
dXJlCglybSAtZiAkKFBLR19CVUlMRF9ESVIpLy5jb25maWd1cmVkKgoJZ3JlcCAnQ09ORklH
X0JVU1lCT1hfJyAkKFRPUERJUikvLmNvbmZpZyB8IHNlZCAtZSAicyxcXCgjIFwpXFw/Q09O
RklHX0JVU1lCT1hfXFwoLipcXCksXFwxXFwyLGciID4gJChQS0dfQlVJTERfRElSKS8uY29u
ZmlnCgl5ZXMgJ24nIHwgJChNQUtFKSAtQyAkKFBLR19CVUlMRF9ESVIpIFwKCQlDQz0iJChU
QVJHRVRfQ0MpIiBcCgkJQ1JPU1NfQ09NUElMRT0iJChUQVJHRVRfQ1JPU1MpIiBcCgkJS0JV
SUxEX0hBVkVfTkxTPW5vIFwKCQlBUkNIPSIkKEFSQ0gpIiBcCgkJJChCQl9NQUtFX1ZFUkJP
U0UpIFwKCQlvbGRjb25maWcKZW5kZWYKCmlmZGVmIENPTkZJR19HQ0NfVkVSU0lPTl9MTFZN
CiAgVEFSR0VUX0NGTEFHUyArPSAtZm5lc3RlZC1mdW5jdGlvbnMKZW5kaWYKCkxETElCUzo9
bSBjcnlwdAoKaWZkZWYgQ09ORklHX0JVU1lCT1hfQ09ORklHX0ZFQVRVUkVfSEFWRV9SUEMK
ICBUQVJHRVRfQ0ZMQUdTICs9IC1JJChTVEFHSU5HX0RJUikvdXNyL2luY2x1ZGUKICBleHBv
cnQgTERGTEFHUz0kKFRBUkdFVF9MREZMQUdTKQogIExETElCUyArPSBycGMKZW5kaWYKCmlm
ZGVmIENPTkZJR19QQUNLQUdFX2x0dG5nLXVzdAogIFRBUkdFVF9DRkxBR1MgKz0gLUkuCiAg
TERMSUJTICs9IGx0dG5nLXVzdCBkbAplbmRpZgoKZGVmaW5lIEJ1aWxkL0NvbXBpbGUKCSsk
KE1BS0UpICQoUEtHX0pPQlMpIC1DICQoUEtHX0JVSUxEX0RJUikgXAoJCUNDPSIkKFRBUkdF
VF9DQykiIFwKCQlDUk9TU19DT01QSUxFPSIkKFRBUkdFVF9DUk9TUykiIFwKCQlLQlVJTERf
SEFWRV9OTFM9bm8gXAoJCUVYVFJBX0NGTEFHUz0iJChUQVJHRVRfQ0ZMQUdTKSIgXAoJCUFS
Q0g9IiQoQVJDSCkiIFwKCQlTS0lQX1NUUklQPXkgXAoJCUxETElCUz0iJChMRExJQlMpIiBc
CgkJJChCQl9NQUtFX1ZFUkJPU0UpIFwKCQlhbGwKCXJtIC1yZiAkKFBLR19JTlNUQUxMX0RJ
UikKCSQoRklORCkgJChQS0dfQlVJTERfRElSKSAtbG5hbWUgIipidXN5Ym94IiAtZXhlYyBy
bSBce1x9IFw7CgkkKE1BS0UpIC1DICQoUEtHX0JVSUxEX0RJUikgXAoJCUNDPSIkKFRBUkdF
VF9DQykiIFwKCQlDUk9TU19DT01QSUxFPSIkKFRBUkdFVF9DUk9TUykiIFwKCQlFWFRSQV9D
RkxBR1M9IiQoVEFSR0VUX0NGTEFHUykiIFwKCQlBUkNIPSIkKEFSQ0gpIiBcCgkJQ09ORklH
X1BSRUZJWD0iJChQS0dfSU5TVEFMTF9ESVIpIiBcCgkJTERMSUJTPSIkKExETElCUykiIFwK
CQkkKEJCX01BS0VfVkVSQk9TRSkgXAoJCWluc3RhbGwKZW5kZWYKCmRlZmluZSBQYWNrYWdl
L2J1c3lib3gvaW5zdGFsbAoJJChJTlNUQUxMX0RJUikgJCgxKS9ldGMvaW5pdC5kCgkkKENQ
KSAkKFBLR19JTlNUQUxMX0RJUikvKiAkKDEpLwoJZm9yIHRtcCBpbiAkKGluaXQteSk7IGRv
IFwKCQkkKElOU1RBTExfQklOKSAuL2ZpbGVzLyQkJCR0bXAgJCgxKS9ldGMvaW5pdC5kLyQk
JCR0bXA7IFwKCWRvbmUKCS1ybSAtcmYgJCgxKS9saWI2NAplbmRlZgoKJChldmFsICQoY2Fs
bCBCdWlsZFBhY2thZ2UsYnVzeWJveCkpCg==
--------------090102060103050408090805
Content-Type: text/x-patch; name="904-telnetd_lttng_events.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="904-telnetd_lttng_events.patch"

--- a/networking/Kbuild.src
+++ b/networking/Kbuild.src
@@ -36,7 +36,7 @@
 lib-$(CONFIG_SLATTACH)     += slattach.o
 lib-$(CONFIG_TC)           += tc.o
 lib-$(CONFIG_TELNET)       += telnet.o
-lib-$(CONFIG_TELNETD)      += telnetd.o
+lib-$(CONFIG_TELNETD)      += telnetd.o telnetd_lttng_events.o
 lib-$(CONFIG_TFTP)         += tftp.o
 lib-$(CONFIG_TFTPD)        += tftp.o
 lib-$(CONFIG_TRACEROUTE)   += traceroute.o

--- a/networking/telnetd.c
+++ b/networking/telnetd.c
@@ -45,6 +45,8 @@
 #include "libbb.h"
 #include <syslog.h>
+#define TRACEPOINT_DEFINE
+#include "telnetd_lttng_events.h"
 
 #if DEBUG
 # define TELCMDS

@@ -68,6 +70,10 @@
 #define TS_BUF2(ts) (((unsigned char*)(ts + 1)) + BUFSIZE)
 	int rdidx1, wridx1, size1;
 	int rdidx2, wridx2, size2;
+        struct {
+           char *client;
+           char *server;
+        } tp;
 };
 
 /* Two buffers are directly after tsession in malloced memory.
@@ -252,6 +258,11 @@
 	char tty_name[GETPTY_BUFSIZE];
 	struct tsession *ts = xzalloc(sizeof(struct tsession) + BUFSIZE * 2);
 
+        if (!ts) {
+            tracepoint(busybox_telnetd, err, "xzalloc", "struct tsession", errno);
+            return 0; 
+        }
+
 	/*ts->buf1 = (char *)(ts + 1);*/
 	/*ts->buf2 = ts->buf1 + BUFSIZE;*/
 
@@ -317,6 +328,7 @@
 		close(fd);
 		/* sock will be closed by caller */
 		bb_perror_msg("vfork");
+                tracepoint(busybox_telnetd, err, "vfork", "session", errno);
 		return NULL;
 	}
 	if (pid > 0) {
@@ -344,7 +356,22 @@
 		write_new_utmp(pid, LOGIN_PROCESS, tty_name, /*username:*/ "LOGIN", hostname);
 		free(hostname);
 	}
-
+        
+        //if (tracepoint_enabled(busybox_telnetd, session))
+        if (1)
+        {        
+            len_and_sockaddr *client_lsa = get_peer_lsa(sock);
+            len_and_sockaddr *server_lsa = get_sock_lsa(sock);
+            if (client_lsa) {
+                ts->tp.client = xmalloc_sockaddr2dotted(&client_lsa->u.sa);
+                free(client_lsa);
+            }
+            if (server_lsa) {
+                ts->tp.server = xmalloc_sockaddr2dotted(&server_lsa->u.sa);
+                free(server_lsa);
+            }
+            tracepoint(busybox_telnetd, session, "new", ts->tp.client, ts->tp.server, pid);
+        }
 	/* Make new session and process group */
 	setsid();

@@ -384,6 +411,7 @@
 	 * fd has CLOEXEC set on it too. These two fds will be closed here.
 	 */
 	BB_EXECVP(G.loginpath, (char **)login_argv);
+        tracepoint(busybox_telnetd, err, "execv", G.loginpath, errno);
 	/* _exit is safer with vfork, and we shouldn't send message
 	 * to remote clients anyway */
 	_exit(EXIT_FAILURE); /*bb_perror_msg_and_die("execv %s", G.loginpath);*/
@@ -421,6 +449,8 @@
 	/* We do not need to close(ts->sockfd_write), it's the same
 	 * as sockfd_read unless we are in inetd mode. But in inetd mode
 	 * we do not reach this */
+        if (ts->tp.client) free(ts->tp.client);
+        if (ts->tp.server) free(ts->tp.server);
 	free(ts);
 
 	/* Scan all sessions and find new maxfd */
@@ -462,6 +492,7 @@
 		while (ts) {
 			if (ts->shell_pid == pid) {
 				ts->shell_pid = -1;
+                                tracepoint(busybox_telnetd, session, "dead", ts->tp.client, ts->tp.server, pid);
 // man utmp:
 // When init(8) finds that a process has exited, it locates its utmp entry
 // by ut_pid, sets ut_type to DEAD_PROCESS, and clears ut_user, ut_host
@@ -501,6 +532,8 @@
 #endif
 	INIT_G();
 
+        tracepoint(busybox_telnetd, info, "Start");
+
 	/* -w NUM, and implies -F. -w and -i don't mix */
 	IF_FEATURE_TELNETD_INETD_WAIT(opt_complementary = "wF:w+:i--w:w--i";)
 	/* Even if !STANDALONE, we accept (and ignore) -i, thus people
@@ -513,6 +546,7 @@
 			IF_FEATURE_TELNETD_INETD_WAIT(, &sec_linger)
 	);
 	if (!IS_INETD /*&& !re_execed*/) {
+                tracepoint(busybox_telnetd, info, "Standalone mode enabled");
 		/* inform that we start in standalone mode?
 		 * May be useful when people forget to give -i */
 		/*bb_error_msg("listening for connections");*/
@@ -524,6 +558,7 @@
 	}
 	/* Redirect log to syslog early, if needed */
 	if (IS_INETD || (opt & OPT_SYSLOG) || !(opt & OPT_FOREGROUND)) {
+                tracepoint(busybox_telnetd, info, "Syslog redirection enabled");
 		openlog(applet_name, LOG_PID, LOG_DAEMON);
 		logmode = LOGMODE_SYSLOG;
 	}

--- a/dev/null
+++ b/networking/telnetd_lttng_events.h
@@ -0,0 +1,59 @@
+#undef TRACEPOINT_PROVIDER
+#define TRACEPOINT_PROVIDER busybox_telnetd
+
+#undef TRACEPOINT_INCLUDE
+#define TRACEPOINT_INCLUDE "networking/telnetd_lttng_events.h"
+
+#if !defined(_TELNETD_EVENTS_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
+#define _TELNETD_EVENTS_H
+#include <lttng/tracepoint.h> 
+
+//TRACEPOINT_FORMAT(busybox_telnetd, info, "TELNETD.1 Info") 
+TRACEPOINT_EVENT(
+    busybox_telnetd,
+    info,
+    TP_ARGS(
+        char *, msg_arg
+    ),
+    TP_FIELDS(
+        ctf_string(msg, msg_arg)
+    )
+)
+
+//TRACEPOINT_FORMAT(busybox_telnetd, err, "TELNETD.2 Err") 
+TRACEPOINT_EVENT(
+    busybox_telnetd,
+    err,
+    TP_ARGS(
+        char *, call_arg,
+        char *, msg_arg,
+        int, errno_arg
+    ),
+    TP_FIELDS(
+        ctf_string(call, call_arg)
+        ctf_string(msg, msg_arg)
+        ctf_integer(int, errno_val, errno_arg)
+    )
+)
+
+//TRACEPOINT_FORMAT(busybox_telnetd, session, "TELNETD.3 Session") 
+TRACEPOINT_EVENT(
+    busybox_telnetd,
+    session,
+    TP_ARGS(
+        char *, msg_arg,
+        char *, client_arg,
+        char *, server_arg,
+        pid_t,  pid_arg
+    ),
+    TP_FIELDS(
+        ctf_string(msg, msg_arg)
+        ctf_string(client, client_arg)
+        ctf_string(server, server_arg)
+        ctf_integer(pid_t, session_pid, pid_arg)
+    )
+)
+
+#endif
+
+#include <lttng/tracepoint-event.h>

--- a/dev/null
+++ b/networking/telnetd_lttng_events.c
@@ -0,0 +1,2 @@
+#define TRACEPOINT_CREATE_PROBES
+#include "telnetd_lttng_events.h"


--------------090102060103050408090805
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------090102060103050408090805--
