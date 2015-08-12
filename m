From: "jia,fang" <fang.jia@windriver.com>
Subject: BUG: lttng-tools enable-event with filter, tracing error
Date: Wed, 12 Aug 2015 17:48:36 +0800
Message-ID: <55CB1674.1060605__17627.2521996454$1439373009$gmane$org@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010009050406090809040702"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.windriver.com ([147.11.1.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Fang.Jia@windriver.com>) id 1ZPSek-0004hJ-Ij
 for lttng-dev@lists.lttng.org; Wed, 12 Aug 2015 05:49:13 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
 [147.11.189.40])
 by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t7C9n4Zf015523
 (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
 for <lttng-dev@lists.lttng.org>; Wed, 12 Aug 2015 02:49:04 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--------------010009050406090809040702
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi,

I found that if you enable-event with filter and then start tracepoint,
you can not stop your tracing even if you disable your event.

Do you have this problem ?


Here is the detail info:

My system is Ubuntu14.04, and Lttng-version is lttng version 2.7.0-pre - Gaia -
v2.6.0-rc1-242-g60f7035.

I build user application "hello" as
http://lttng.org/docs/v2.6/#doc-tracing-your-own-user-application told. And
change the hello.c as follow:
for(;;)
{
sleep(2);
for (x = 0; x < argc; ++x) {
        tracepoint(hello_world, my_first_tracepoint, x, argv[x]);
    }
}

Then I do this:
1/ lttng create mysession
2/ lttng enable-event hello_world:my_first_tracepoint --filter '$ctx.procname ==
"./hello*"' --session mysession -u -c channel

3/ lttng enable-event hello_world:my_first_tracepoint --session mysession -u -c
channel

4/ ./hello &
I press Enter to start tracepoint

5/ lttng disable-event --session mysession --channel channel --userspace
hello_world:my_first_tracepoint

6/ lttng start

7/ lttng stop

8/ lttng view

My detail log is as attachment


--------------010009050406090809040702
Content-Type: text/plain; charset="UTF-8"; name="test_log_of_Ubuntu"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="test_log_of_Ubuntu"

d3JzYWRtaW5AcGVrLWZqaWEtZDE6fi93b3JrcGxhY2UvbHR0bmdfdGVzdCQgbHR0bmcgY3Jl
YXRlIG15c2Vzc2lvbgpTZXNzaW9uIG15c2Vzc2lvbiBjcmVhdGVkLgpUcmFjZXMgd2lsbCBi
ZSB3cml0dGVuIGluIC9ob21lL3dyc2FkbWluL2x0dG5nLXRyYWNlcy9teXNlc3Npb24tMjAx
NTA4MTItMTc0MzIwCndyc2FkbWluQHBlay1mamlhLWQxOn4vd29ya3BsYWNlL2x0dG5nX3Rl
c3QkCndyc2FkbWluQHBlay1mamlhLWQxOn4vd29ya3BsYWNlL2x0dG5nX3Rlc3QkCndyc2Fk
bWluQHBlay1mamlhLWQxOn4vd29ya3BsYWNlL2x0dG5nX3Rlc3QkICBsdHRuZyBlbmFibGUt
ZXZlbnQgaGVsbG9fd29ybGQ6bXlfZmlyc3RfdHJhY2Vwb2ludCAtLWZpbHRlciAnJGN0eC5w
cm9jbmFtZSA9PSAiLi9oZWxsbyoiJyAtLXNlc3Npb24gbXlzZXNzaW9uIC11IC1jIGNoYW5u
ZWwKRXZlbnQgaGVsbG9fd29ybGQ6bXlfZmlyc3RfdHJhY2Vwb2ludDogRmlsdGVyICckY3R4
LnByb2NuYW1lID09ICIuL2hlbGxvKiInIHN1Y2Nlc3NmdWxseSBzZXQKd3JzYWRtaW5AcGVr
LWZqaWEtZDE6fi93b3JrcGxhY2UvbHR0bmdfdGVzdCQgbHR0bmcgZW5hYmxlLWV2ZW50IGhl
bGxvX3dvcmxkOm15X2ZpcnN0X3RyYWNlcG9pbnQgLS1zZXNzaW9uIG15c2Vzc2lvbiAtdSAt
YyBjaGFubmVsClVTVCBldmVudCBoZWxsb193b3JsZDpteV9maXJzdF90cmFjZXBvaW50IGNy
ZWF0ZWQgaW4gY2hhbm5lbCBjaGFubmVsCndyc2FkbWluQHBlay1mamlhLWQxOn4vd29ya3Bs
YWNlL2x0dG5nX3Rlc3QkCndyc2FkbWluQHBlay1mamlhLWQxOn4vd29ya3BsYWNlL2x0dG5n
X3Rlc3QkIGx0dG5nIGRpc2FibGUtZXZlbnQgLS1zZXNzaW9uIG15c2Vzc2lvbiAtLWNoYW5u
ZWwgY2hhbm5lbCAtLXVzZXJzcGFjZSBoZWxsb193b3JsZDpteV9maXJzdF90cmFjZXBvaW50
ClVTVCBldmVudCBoZWxsb193b3JsZDpteV9maXJzdF90cmFjZXBvaW50IGRpc2FibGVkIGlu
IGNoYW5uZWwgY2hhbm5lbCBmb3Igc2Vzc2lvbiBteXNlc3Npb24Kd3JzYWRtaW5AcGVrLWZq
aWEtZDE6fi93b3JrcGxhY2UvbHR0bmdfdGVzdCQgbHR0bmcgbGlzdCBteXNlc3Npb24KVHJh
Y2luZyBzZXNzaW9uIG15c2Vzc2lvbjogW2luYWN0aXZlXQogICAgVHJhY2UgcGF0aDogL2hv
bWUvd3JzYWRtaW4vbHR0bmctdHJhY2VzL215c2Vzc2lvbi0yMDE1MDgxMi0xNzQzMjAKCj09
PSBEb21haW46IFVTVCBnbG9iYWwgPT09CgpCdWZmZXIgdHlwZTogcGVyIFVJRAoKQ2hhbm5l
bHM6Ci0tLS0tLS0tLS0tLS0KLSBjaGFubmVsOiBbZW5hYmxlZF0KCiAgICBBdHRyaWJ1dGVz
OgogICAgICBvdmVyd3JpdGUgbW9kZTogMAogICAgICBzdWJidWZlcnMgc2l6ZTogMTMxMDcy
CiAgICAgIG51bWJlciBvZiBzdWJidWZlcnM6IDQKICAgICAgc3dpdGNoIHRpbWVyIGludGVy
dmFsOiAwCiAgICAgIHJlYWQgdGltZXIgaW50ZXJ2YWw6IDAKICAgICAgdHJhY2UgZmlsZSBj
b3VudDogMAogICAgICB0cmFjZSBmaWxlIHNpemUgKGJ5dGVzKTogMAogICAgICBvdXRwdXQ6
IG1tYXAoKQoKICAgIEV2ZW50czoKICAgICAgaGVsbG9fd29ybGQ6bXlfZmlyc3RfdHJhY2Vw
b2ludCAodHlwZTogdHJhY2Vwb2ludCkgW2Rpc2FibGVkXQogICAgICBoZWxsb193b3JsZDpt
eV9maXJzdF90cmFjZXBvaW50ICh0eXBlOiB0cmFjZXBvaW50KSBbZGlzYWJsZWRdIFt3aXRo
IGZpbHRlcl0KCndyc2FkbWluQHBlay1mamlhLWQxOn4vd29ya3BsYWNlL2x0dG5nX3Rlc3Qk
IGx0dG5nIHN0YXJ0ClRyYWNpbmcgc3RhcnRlZCBmb3Igc2Vzc2lvbiBteXNlc3Npb24Kd3Jz
YWRtaW5AcGVrLWZqaWEtZDE6fi93b3JrcGxhY2UvbHR0bmdfdGVzdCQgbHR0bmcgc3RvcApX
YWl0aW5nIGZvciBkYXRhIGF2YWlsYWJpbGl0eWwuClRyYWNpbmcgc3RvcHBlZCBmb3Igc2Vz
c2lvbiBteXNlc3Npb24Kd3JzYWRtaW5AcGVrLWZqaWEtZDE6fi93b3JrcGxhY2UvbHR0bmdf
dGVzdCQgbHR0bmcgdmlldwpUcmFjZSBkaXJlY3Rvcnk6IC9ob21lL3dyc2FkbWluL2x0dG5n
LXRyYWNlcy9teXNlc3Npb24tMjAxNTA4MTItMTc0MzIwCgpbMTc6NDQ6NTEuMjU0MjM2NDQx
XSAoKz8uPz8/Pz8/Pz8/KSBwZWstZmppYS1kMSBoZWxsb193b3JsZDpteV9maXJzdF90cmFj
ZXBvaW50OiB7IGNwdV9pZCA9IDMgfSwgeyBteV9zdHJpbmdfZmllbGQgPSAiaGkgdGhlcmUh
IiwgbXlfaW50ZWdlcl9maWVsZCA9IDIzIH0KWzE3OjQ0OjUxLjI1NDI0NTkwMl0gKCswLjAw
MDAwOTQ2MSkgcGVrLWZqaWEtZDEgaGVsbG9fd29ybGQ6bXlfZmlyc3RfdHJhY2Vwb2ludDog
eyBjcHVfaWQgPSAzIH0sIHsgbXlfc3RyaW5nX2ZpZWxkID0gIi4vaGVsbG8iLCBteV9pbnRl
Z2VyX2ZpZWxkID0gMCB9Cg==
--------------010009050406090809040702
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------010009050406090809040702--
