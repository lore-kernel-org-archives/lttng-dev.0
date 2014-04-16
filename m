From: =?UTF-8?B?U8OpYmFzdGllbiBCYXJ0aMOpbMOpbXk=?= <barthelemy@crans.org>
Subject: memory usage depending on number and size of subbuffers
Date: Wed, 16 Apr 2014 18:22:42 +0200
Message-ID: <CAPkDDd40zkVK46vZ-x6SaDvBLvwufN219T+9d36neg95F0WH-g__34166.098785545$1397665436$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1404773878=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sebastien.barthelemy@gmail.com>) id 1WaSbo-00021b-Cu
 for lttng-dev@lists.lttng.org; Wed, 16 Apr 2014 12:22:54 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so11012042wgh.34
 for <lttng-dev@lists.lttng.org>; Wed, 16 Apr 2014 09:22:42 -0700 (PDT)
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

--===============1404773878==
Content-Type: multipart/alternative; boundary=f46d04447e756bc1a204f72b53d7

--f46d04447e756bc1a204f72b53d7
Content-Type: text/plain; charset=UTF-8

Hi all,

LTTng uses more memory than I expected. On the simple experiment below one
can see that the "cached" memory increases by

subbuf_size*num_cpu*(num_subbuf+1)

That's not a big deal, but I did not expect the "+1".

Does somebody know where it comes from?


-- Regards, Sebastien


12M == 2M*2*(2+1)
24M == 4M*2*(2+1)
20M == 2M*2*(4+1)
40M == 4M*2*(4+1)

# grep processor /proc/cpuinfo
processor       : 0
processor       : 1

# lttng create
Session auto-20140416-180246 created.
Traces will be written in /root/lttng-traces/auto-20140416-180246

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        670        332          0         22        250
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng enable-channel channel0 --num-subbuf 2 --subbuf-size 2M -u
UST channel channel0 enabled for session auto-20140416-180246

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        682        320          0         22        262
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng destroy
Session auto-20140416-180246 destroyed

# lttng create
Session auto-20140416-180317 created.
Traces will be written in /root/lttng-traces/auto-20140416-180317

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        670        332          0         22        250
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng enable-channel channel0 --num-subbuf 2 --subbuf-size 4M -u
UST channel channel0 enabled for session auto-20140416-180317

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        694        307          0         22        274
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng destroy
Session auto-20140416-180317 destroyed

# lttng create
Session auto-20140416-180339 created.
Traces will be written in /root/lttng-traces/auto-20140416-180339

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        670        332          0         22        250
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng enable-channel channel0 --num-subbuf 4 --subbuf-size 2M -u
UST channel channel0 enabled for session auto-20140416-180339

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        690        311          0         22        270
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng destroy
Session auto-20140416-180339 destroyed

# lttng create
Session auto-20140416-180406 created.
Traces will be written in /root/lttng-traces/auto-20140416-180406

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        670        332          0         22        250
-/+ buffers/cache:        397        605
Swap:            0          0          0

# lttng enable-channel channel0 --num-subbuf 4 --subbuf-size 4M -u
UST channel channel0 enabled for session auto-20140416-180406

# free -m
             total       used       free     shared    buffers     cached
Mem:          1002        710        292          0         22        290
-/+ buffers/cache:        397        605

--f46d04447e756bc1a204f72b53d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj48ZGl2PkhpIGFsbCwgPGJyPjxicj48L2Rpdj5MVFRuZyB1c2Vz
IG1vcmUgbWVtb3J5IHRoYW4gSSBleHBlY3RlZC4gT24gdGhlIHNpbXBsZSBleHBlcmltZW50IGJl
bG93DQpvbmUgY2FuIHNlZSB0aGF0IHRoZSAmcXVvdDtjYWNoZWQmcXVvdDsgbWVtb3J5IGluY3Jl
YXNlcyBieTxicj48YnI+c3ViYnVmX3NpemUqbnVtX2NwdSoobnVtX3N1YmJ1ZisxKTxicj48YnI+
PC9kaXY+PGRpdj5UaGF0JiMzOTtzIG5vdCBhIGJpZyBkZWFsLCBidXQgSSBkaWQgbm90IGV4cGVj
dCB0aGUgJnF1b3Q7KzEmcXVvdDsuPGJyPjxicj5Eb2VzIHNvbWVib2R5IGtub3cgd2hlcmUgaXQg
Y29tZXMgZnJvbT88YnI+DQo8YnI+PGJyPjwvZGl2PjxkaXY+LS0gUmVnYXJkcywgU2ViYXN0aWVu
PGJyPjxicj48YnI+PC9kaXY+PGRpdj4xMk0gPT0gMk0qMiooMisxKTxicj4yNE0gPT0gNE0qMioo
MisxKTxicj4yME0gPT0gMk0qMiooNCsxKTxicj40ME0gPT0gNE0qMiooNCsxKTxicj48L2Rpdj48
ZGl2Pjxicj4jIGdyZXAgcHJvY2Vzc29yIC9wcm9jL2NwdWluZm88YnI+cHJvY2Vzc29ywqDCoMKg
wqDCoMKgIDogMDxicj5wcm9jZXNzb3LCoMKgwqDCoMKgwqAgOiAxPGJyPg0KPGJyPiMgbHR0bmcg
Y3JlYXRlPGJyPlNlc3Npb24gYXV0by0yMDE0MDQxNi0xODAyNDYgY3JlYXRlZC48YnI+VHJhY2Vz
IHdpbGwgYmUgd3JpdHRlbiBpbiAvcm9vdC9sdHRuZy10cmFjZXMvYXV0by0yMDE0MDQxNi0xODAy
NDY8YnI+PGJyPiMgZnJlZSAtbTxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdG90YWzCoMKg
wqDCoMKgwqAgdXNlZMKgwqDCoMKgwqDCoCBmcmVlwqDCoMKgwqAgc2hhcmVkwqDCoMKgIGJ1ZmZl
cnPCoMKgwqDCoCBjYWNoZWQ8YnI+DQpNZW06wqDCoMKgwqDCoMKgwqDCoMKgIDEwMDLCoMKgwqDC
oMKgwqDCoCA2NzDCoMKgwqDCoMKgwqDCoCAzMzLCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKg
wqDCoMKgwqAgMjLCoMKgwqDCoMKgwqDCoCAyNTA8YnI+LS8rIGJ1ZmZlcnMvY2FjaGU6wqDCoMKg
wqDCoMKgwqAgMzk3wqDCoMKgwqDCoMKgwqAgNjA1PGJyPlN3YXA6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgMDxicj48YnI+IyBs
dHRuZyBlbmFibGUtY2hhbm5lbCBjaGFubmVsMCAtLW51bS1zdWJidWYgMiAtLXN1YmJ1Zi1zaXpl
IDJNIC11PGJyPg0KVVNUIGNoYW5uZWwgY2hhbm5lbDAgZW5hYmxlZCBmb3Igc2Vzc2lvbiBhdXRv
LTIwMTQwNDE2LTE4MDI0Njxicj48YnI+IyBmcmVlIC1tPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0b3RhbMKgwqDCoMKgwqDCoCB1c2VkwqDCoMKgwqDCoMKgIGZyZWXCoMKgwqDCoCBzaGFy
ZWTCoMKgwqAgYnVmZmVyc8KgwqDCoMKgIGNhY2hlZDxicj5NZW06wqDCoMKgwqDCoMKgwqDCoMKg
IDEwMDLCoMKgwqDCoMKgwqDCoCA2ODLCoMKgwqDCoMKgwqDCoCAzMjDCoMKgwqDCoMKgwqDCoMKg
wqAgMMKgwqDCoMKgwqDCoMKgwqAgMjLCoMKgwqDCoMKgwqDCoCAyNjI8YnI+DQotLysgYnVmZmVy
cy9jYWNoZTrCoMKgwqDCoMKgwqDCoCAzOTfCoMKgwqDCoMKgwqDCoCA2MDU8YnI+U3dhcDrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqDC
oCAwPGJyPjxicj4jIGx0dG5nIGRlc3Ryb3k8YnI+U2Vzc2lvbiBhdXRvLTIwMTQwNDE2LTE4MDI0
NiBkZXN0cm95ZWQ8YnI+PGJyPiMgbHR0bmcgY3JlYXRlPGJyPlNlc3Npb24gYXV0by0yMDE0MDQx
Ni0xODAzMTcgY3JlYXRlZC48YnI+VHJhY2VzIHdpbGwgYmUgd3JpdHRlbiBpbiAvcm9vdC9sdHRu
Zy10cmFjZXMvYXV0by0yMDE0MDQxNi0xODAzMTc8YnI+DQo8YnI+IyBmcmVlIC1tPGJyPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB0b3RhbMKgwqDCoMKgwqDCoCB1c2VkwqDCoMKgwqDCoMKgIGZy
ZWXCoMKgwqDCoCBzaGFyZWTCoMKgwqAgYnVmZmVyc8KgwqDCoMKgIGNhY2hlZDxicj5NZW06wqDC
oMKgwqDCoMKgwqDCoMKgIDEwMDLCoMKgwqDCoMKgwqDCoCA2NzDCoMKgwqDCoMKgwqDCoCAzMzLC
oMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqAgMjLCoMKgwqDCoMKgwqDCoCAyNTA8
YnI+LS8rIGJ1ZmZlcnMvY2FjaGU6wqDCoMKgwqDCoMKgwqAgMzk3wqDCoMKgwqDCoMKgwqAgNjA1
PGJyPlN3YXA6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKg
wqDCoMKgwqDCoMKgwqAgMDxicj4NCjxicj4jIGx0dG5nIGVuYWJsZS1jaGFubmVsIGNoYW5uZWww
IC0tbnVtLXN1YmJ1ZiAyIC0tc3ViYnVmLXNpemUgNE0gLXU8YnI+VVNUIGNoYW5uZWwgY2hhbm5l
bDAgZW5hYmxlZCBmb3Igc2Vzc2lvbiBhdXRvLTIwMTQwNDE2LTE4MDMxNzxicj48YnI+IyBmcmVl
IC1tPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0b3RhbMKgwqDCoMKgwqDCoCB1c2VkwqDC
oMKgwqDCoMKgIGZyZWXCoMKgwqDCoCBzaGFyZWTCoMKgwqAgYnVmZmVyc8KgwqDCoMKgIGNhY2hl
ZDxicj4NCk1lbTrCoMKgwqDCoMKgwqDCoMKgwqAgMTAwMsKgwqDCoMKgwqDCoMKgIDY5NMKgwqDC
oMKgwqDCoMKgIDMwN8KgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoCAyMsKgwqDC
oMKgwqDCoMKgIDI3NDxicj4tLysgYnVmZmVycy9jYWNoZTrCoMKgwqDCoMKgwqDCoCAzOTfCoMKg
wqDCoMKgwqDCoCA2MDU8YnI+U3dhcDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKg
wqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqDCoCAwPGJyPjxicj4jIGx0dG5nIGRlc3Ryb3k8YnI+
U2Vzc2lvbiBhdXRvLTIwMTQwNDE2LTE4MDMxNyBkZXN0cm95ZWQ8YnI+DQo8YnI+IyBsdHRuZyBj
cmVhdGU8YnI+U2Vzc2lvbiBhdXRvLTIwMTQwNDE2LTE4MDMzOSBjcmVhdGVkLjxicj5UcmFjZXMg
d2lsbCBiZSB3cml0dGVuIGluIC9yb290L2x0dG5nLXRyYWNlcy9hdXRvLTIwMTQwNDE2LTE4MDMz
OTxicj48YnI+IyBmcmVlIC1tPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0b3RhbMKgwqDC
oMKgwqDCoCB1c2VkwqDCoMKgwqDCoMKgIGZyZWXCoMKgwqDCoCBzaGFyZWTCoMKgwqAgYnVmZmVy
c8KgwqDCoMKgIGNhY2hlZDxicj4NCk1lbTrCoMKgwqDCoMKgwqDCoMKgwqAgMTAwMsKgwqDCoMKg
wqDCoMKgIDY3MMKgwqDCoMKgwqDCoMKgIDMzMsKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDC
oMKgwqDCoCAyMsKgwqDCoMKgwqDCoMKgIDI1MDxicj4tLysgYnVmZmVycy9jYWNoZTrCoMKgwqDC
oMKgwqDCoCAzOTfCoMKgwqDCoMKgwqDCoCA2MDU8YnI+U3dhcDrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqDCoCAwPGJyPjxicj4jIGx0
dG5nIGVuYWJsZS1jaGFubmVsIGNoYW5uZWwwIC0tbnVtLXN1YmJ1ZiA0IC0tc3ViYnVmLXNpemUg
Mk0gLXU8YnI+DQpVU1QgY2hhbm5lbCBjaGFubmVsMCBlbmFibGVkIGZvciBzZXNzaW9uIGF1dG8t
MjAxNDA0MTYtMTgwMzM5PGJyPjxicj4jIGZyZWUgLW08YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRvdGFswqDCoMKgwqDCoMKgIHVzZWTCoMKgwqDCoMKgwqAgZnJlZcKgwqDCoMKgIHNoYXJl
ZMKgwqDCoCBidWZmZXJzwqDCoMKgwqAgY2FjaGVkPGJyPk1lbTrCoMKgwqDCoMKgwqDCoMKgwqAg
MTAwMsKgwqDCoMKgwqDCoMKgIDY5MMKgwqDCoMKgwqDCoMKgIDMxMcKgwqDCoMKgwqDCoMKgwqDC
oCAwwqDCoMKgwqDCoMKgwqDCoCAyMsKgwqDCoMKgwqDCoMKgIDI3MDxicj4NCi0vKyBidWZmZXJz
L2NhY2hlOsKgwqDCoMKgwqDCoMKgIDM5N8KgwqDCoMKgwqDCoMKgIDYwNTxicj5Td2FwOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKg
IDA8YnI+PGJyPiMgbHR0bmcgZGVzdHJveTxicj5TZXNzaW9uIGF1dG8tMjAxNDA0MTYtMTgwMzM5
IGRlc3Ryb3llZDxicj48YnI+IyBsdHRuZyBjcmVhdGU8YnI+U2Vzc2lvbiBhdXRvLTIwMTQwNDE2
LTE4MDQwNiBjcmVhdGVkLjxicj5UcmFjZXMgd2lsbCBiZSB3cml0dGVuIGluIC9yb290L2x0dG5n
LXRyYWNlcy9hdXRvLTIwMTQwNDE2LTE4MDQwNjxicj4NCjxicj4jIGZyZWUgLW08YnI+wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHRvdGFswqDCoMKgwqDCoMKgIHVzZWTCoMKgwqDCoMKgwqAgZnJl
ZcKgwqDCoMKgIHNoYXJlZMKgwqDCoCBidWZmZXJzwqDCoMKgwqAgY2FjaGVkPGJyPk1lbTrCoMKg
wqDCoMKgwqDCoMKgwqAgMTAwMsKgwqDCoMKgwqDCoMKgIDY3MMKgwqDCoMKgwqDCoMKgIDMzMsKg
wqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoCAyMsKgwqDCoMKgwqDCoMKgIDI1MDxi
cj4tLysgYnVmZmVycy9jYWNoZTrCoMKgwqDCoMKgwqDCoCAzOTfCoMKgwqDCoMKgwqDCoCA2MDU8
YnI+U3dhcDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgMMKgwqDC
oMKgwqDCoMKgwqDCoCAwPGJyPg0KPGJyPiMgbHR0bmcgZW5hYmxlLWNoYW5uZWwgY2hhbm5lbDAg
LS1udW0tc3ViYnVmIDQgLS1zdWJidWYtc2l6ZSA0TSAtdTxicj5VU1QgY2hhbm5lbCBjaGFubmVs
MCBlbmFibGVkIGZvciBzZXNzaW9uIGF1dG8tMjAxNDA0MTYtMTgwNDA2PGJyPjxicj4jIGZyZWUg
LW08YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRvdGFswqDCoMKgwqDCoMKgIHVzZWTCoMKg
wqDCoMKgwqAgZnJlZcKgwqDCoMKgIHNoYXJlZMKgwqDCoCBidWZmZXJzwqDCoMKgwqAgY2FjaGVk
PGJyPg0KTWVtOsKgwqDCoMKgwqDCoMKgwqDCoCAxMDAywqDCoMKgwqDCoMKgwqAgNzEwwqDCoMKg
wqDCoMKgwqAgMjkywqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgwqDCoMKgIDIywqDCoMKg
wqDCoMKgwqAgMjkwPGJyPi0vKyBidWZmZXJzL2NhY2hlOsKgwqDCoMKgwqDCoMKgIDM5N8KgwqDC
oMKgwqDCoMKgIDYwNTxicj48YnI+PC9kaXY+PC9kaXY+DQo=
--f46d04447e756bc1a204f72b53d7--


--===============1404773878==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1404773878==--
