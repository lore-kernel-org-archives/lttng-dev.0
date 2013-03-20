From: Dragos Tarcatu <tarcatu_dragosh@yahoo.com>
Subject: [lttng-tools PATCH] Trivial build fix
Date: Wed, 20 Mar 2013 05:46:46 -0700 (PDT)
Message-ID: <1363783606.35366.YahooMailNeo__25210.8072083958$1363783666$gmane$org@web120204.mail.ne1.yahoo.com>
Reply-To: Dragos Tarcatu <tarcatu_dragosh@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="1326060354-1590004185-1363783606=:35366"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm16-vm0.bullet.mail.ne1.yahoo.com ([98.138.91.49])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tarcatu_dragosh@yahoo.com>) id 1UIIPs-0008QS-Q0
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 08:46:53 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--1326060354-1590004185-1363783606=:35366
Content-Type: multipart/alternative; boundary="1326060354-816823581-1363783606=:35366"

--1326060354-816823581-1363783606=:35366
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,=0A=0AI've got into a build error on Ubuntu 12.04 (i386) using gcc 4=
.6.3. The compiler seems to get confused when asked to equivalate unsigned =
long and uint64_t on my machine. Since the problem was pretty obvious, I've=
 also made a patch for it.=0A=0A=0ARegards,=0A=A0=A0=A0 Dragos=0A
--1326060354-816823581-1363783606=:35366
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi all,</div><di=
v><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family=
: times new roman,new york,times,serif; background-color: transparent; font=
-style: normal;">I've got into a build error on Ubuntu 12.04 (i386) using g=
cc 4.6.3. The compiler seems to get confused when asked to equivalate unsig=
ned long and uint64_t on my machine. Since the problem was pretty obvious, =
I've also made a patch for it.<br></div><div style=3D"color: rgb(0, 0, 0); =
font-size: 16px; font-family: times new roman,new york,times,serif; backgro=
und-color: transparent; font-style: normal;"><br></div><div style=3D"color:=
 rgb(0, 0, 0); font-size: 16px; font-family: times new roman,new york,times=
,serif; background-color: transparent; font-style: normal;">Regards,</div><=
div style=3D"color: rgb(0, 0, 0); font-size: 16px; font-family: times new
 roman,new york,times,serif; background-color: transparent; font-style: nor=
mal;">&nbsp;&nbsp;&nbsp; Dragos<br></div></div></body></html>
--1326060354-816823581-1363783606=:35366--

--1326060354-1590004185-1363783606=:35366
Content-Type: text/x-diff; name="patch.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.diff"

RnJvbSBjMTUyMmQ5MzQ2NzgzY2Q5OTFlM2ViYmU2YmYzNDQxMjJkYWRmMWFk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEcmFnb3MgVGFyY2F0
dSA8dGFyY2F0dV9kcmFnb3NoQHlhaG9vLmNvbT4KRGF0ZTogV2VkLCAyMCBN
YXIgMjAxMyAyMTo0MjoyMyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIFJlcGxh
Y2VkIHVuc2lnbmVkIGxvbmcgd2l0aCB1aW50NjRfdCB0byBhdm9pZCBVYnVu
dHUvZ2NjCiA0LjYuMyBjb21waWxhdGlvbiBlcnJvcnMuCgotLS0KIHNyYy9j
b21tb24vY29uc3VtZXIuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Ny
Yy9jb21tb24vY29uc3VtZXIuYyBiL3NyYy9jb21tb24vY29uc3VtZXIuYwpp
bmRleCAzMDBmZDJhLi44NzMwZTM5IDEwMDY0NAotLS0gYS9zcmMvY29tbW9u
L2NvbnN1bWVyLmMKKysrIGIvc3JjL2NvbW1vbi9jb25zdW1lci5jCkBAIC04
MjAsNyArODIwLDcgQEAgZXJyb3I6CiAgKgogICogT24gZXJyb3IsIHJldHVy
biBOVUxMLgogICovCi1zdHJ1Y3QgbHR0bmdfY29uc3VtZXJfY2hhbm5lbCAq
Y29uc3VtZXJfYWxsb2NhdGVfY2hhbm5lbCh1bnNpZ25lZCBsb25nIGtleSwK
K3N0cnVjdCBsdHRuZ19jb25zdW1lcl9jaGFubmVsICpjb25zdW1lcl9hbGxv
Y2F0ZV9jaGFubmVsKHVpbnQ2NF90IGtleSwKIAkJdWludDY0X3Qgc2Vzc2lv
bl9pZCwKIAkJY29uc3QgY2hhciAqcGF0aG5hbWUsCiAJCWNvbnN0IGNoYXIg
Km5hbWUsCi0tIAoxLjcuOS41Cgo=

--1326060354-1590004185-1363783606=:35366
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--1326060354-1590004185-1363783606=:35366--
