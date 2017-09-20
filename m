From: liguang li <liguang.lee6@gmail.com>
Subject: Missing discarded events message in live-reading mode
Date: Wed, 20 Sep 2017 17:37:30 +0800
Message-ID: <CAMYaK0RsEf4NaEV5ATXDyVoWq4sWQ5uLu4eWW0nVOzn43VwWGw__47559.0058522814$1505917630$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3649287111735531651=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt0-x232.google.com (mail-qt0-x232.google.com
 [IPv6:2607:f8b0:400d:c0d::232])
 by lists.lttng.org (Postfix) with ESMTPS id 3xxvmD0t6kzt7d
 for <lttng-dev@lists.lttng.org>; Wed, 20 Sep 2017 09:37:31 +0000 (UTC)
Received: by mail-qt0-x232.google.com with SMTP id o52so2154181qtc.9
 for <lttng-dev@lists.lttng.org>; Wed, 20 Sep 2017 02:37:31 -0700 (PDT)
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============3649287111735531651==
Content-Type: multipart/alternative; boundary="001a11408c128459ab05599bb904"

--001a11408c128459ab05599bb904
Content-Type: text/plain; charset="UTF-8"

Hi,

Babeltrace in live mode is not displaying the discarded events message. But
on CTF traces the discarded events message will be printed on stderr.

Why? Is there any restriction?

I added the following patch into the ctf_live_packet_seek() function, and
found
it works well. Is there any side effect?

diff --git a/formats/lttng-live/lttng-live-comm.c
b/formats/lttng-live/lttng-live-comm.c
index a1c95bb..dc14bf5 100644
--- a/formats/lttng-live/lttng-live-comm.c
+++ b/formats/lttng-live/lttng-live-comm.c
@@ -1297,6 +1297,11 @@ retry:
                ctf_update_current_packet_index(&file_stream->parent,
                                prev_index, cur_index);

+               if
((&file_stream->parent)->stream_class->trace->parent.collection) {
+                       ctf_print_discarded_lost(stderr,
&file_stream->parent);
+               }
+
+
                file_stream->parent.cycles_timestamp =
                                cur_index->ts_cycles.timestamp_begin;
                file_stream->parent.real_timestamp =
...


Regards,
Liguang

--001a11408c128459ab05599bb904
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8YnI+PGJyPkJhYmVsdHJhY2UgaW4gbGl2ZSBtb2RlIGlz
IG5vdCBkaXNwbGF5aW5nIHRoZSBkaXNjYXJkZWQgZXZlbnRzIG1lc3NhZ2UuIA0KQnV0IDxicj5v
biBDVEYgdHJhY2VzIHRoZSBkaXNjYXJkZWQgZXZlbnRzIG1lc3NhZ2Ugd2lsbCBiZSBwcmludGVk
IG9uIHN0ZGVyci4gPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2h5PyBJcyB0aGVyZSBh
bnkgcmVzdHJpY3Rpb24/PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBhZGRlZCB0aGUg
Zm9sbG93aW5nIHBhdGNoIGludG8gdGhlIGN0Zl9saXZlX3BhY2tldF9zZWVrKCkgZnVuY3Rpb24s
IGFuZCBmb3VuZDwvZGl2PjxkaXY+aXQgd29ya3Mgd2VsbC4gSXMgdGhlcmUgYW55IHNpZGUgZWZm
ZWN0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+ZGlmZiAtLWdpdCBhL2Zvcm1hdHMvbHR0bmct
bGl2ZS9sdHRuZy1saXZlLWNvbW0uYyBiL2Zvcm1hdHMvbHR0bmctbGl2ZS9sdHRuZy1saXZlLWNv
bW0uYzxicj5pbmRleCBhMWM5NWJiLi5kYzE0YmY1IDEwMDY0NDxicj4tLS0gYS9mb3JtYXRzL2x0
dG5nLWxpdmUvbHR0bmctbGl2ZS1jb21tLmM8YnI+KysrIGIvZm9ybWF0cy9sdHRuZy1saXZlL2x0
dG5nLWxpdmUtY29tbS5jPGJyPkBAIC0xMjk3LDYgKzEyOTcsMTEgQEAgcmV0cnk6PGJyPsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdGZfdXBkYXRlX2N1cnJlbnRfcGFja2V0X2luZGV4
KCZhbXA7ZmlsZV9zdHJlYW0tJmd0O3BhcmVudCw8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJldl9pbmRleCwgY3VyX2lu
ZGV4KTs8YnI+wqA8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCgmYW1wO2Zp
bGVfc3RyZWFtLSZndDtwYXJlbnQpLSZndDtzdHJlYW1fY2xhc3MtJmd0O3RyYWNlLSZndDtwYXJl
bnQuY29sbGVjdGlvbikgezxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgY3RmX3ByaW50X2Rpc2NhcmRlZF9sb3N0KHN0ZGVyciwgJmFtcDtmaWxlX3N0cmVh
bS0mZ3Q7cGFyZW50KTs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTxicj4rPGJy
Pis8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbGVfc3RyZWFtLSZndDtwYXJl
bnQuY3ljbGVzX3RpbWVzdGFtcCA9PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cl9pbmRleC0mZ3Q7dHNfY3ljbGVzLnRp
bWVzdGFtcF9iZWdpbjs8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZpbGVfc3Ry
ZWFtLSZndDtwYXJlbnQucmVhbF90aW1lc3RhbXAgPTxicj48L2Rpdj48ZGl2Pi4uLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rpdj48ZGl2PkxpZ3Vh
bmc8YnI+PC9kaXY+DQo8L2Rpdj4NCg==
--001a11408c128459ab05599bb904--

--===============3649287111735531651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============3649287111735531651==--
