From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: Re: 2.7.0 not support enable-event -k -a
Date: Tue, 10 Nov 2015 10:09:53 -0500
Message-ID: <CA+jJMxuSvSc+UFE-jfooX6qqQmsHZOMCJV506XqwmNKaNuxpzg__32987.1760485277$1447168254$gmane$org@mail.gmail.com>
References: <a66fb4c0-6937-49d3-ab21-51dbf91ec4ce.zhenyu.ren@aliyun.com>
 <564206FD.3050308@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZwAYY-000616-MB
 for lttng-dev@lists.lttng.org; Tue, 10 Nov 2015 10:09:59 -0500
Received: by ykdr82 with SMTP id r82so38823811ykd.3
 for <lttng-dev@lists.lttng.org>; Tue, 10 Nov 2015 07:09:53 -0800 (PST)
In-Reply-To: <564206FD.3050308@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gVHVlLCBOb3YgMTAsIDIwMTUgYXQgMTA6MDIgQU0sIEpvbmF0aGFuIFJham90dGUgSnVsaWVu
CjxKb25hdGhhbi5yYWpvdHRlLWp1bGllbkBlZmZpY2lvcy5jb20+IHdyb3RlOgo+IEhpIFpoZW55
dSwKPgo+IEkganVzdCB0ZXN0ZWQgaXQgb24gYSBVYnVudHUgMTUuMTAgd2l0aCBrZXJuZWwgNC4y
LjMgd2l0aCBubyBwcm9ibGVtLgo+Cj4gRGlkIHlvdSBpbnN0YWxsIGZyb20gc291cmNlL3BwYSA/
IENvdWxkIHlvdSBnaXZlIHVzIGFsbCB0aGUgc3RlcHMgaW52b2x2ZWQgPwo+Cj4gTWFrZSBzdXJl
IHRvIGdvIG92ZXIgWzFdIHRvIGhlbHAgdXMgcGlucG9pbnQgdGhlIHByb2JsZW0uCj4KPiBbMV0g
aHR0cHM6Ly9sdHRuZy5vcmcvY29tbXVuaXR5LyNidWctcmVwb3J0aW5nLWd1aWRlbGluZXMKCk1h
a2Ugc3VyZSB5b3UgaW5jbHVkZSB0aGUgdmVyYm9zZSBsb2dzIG9mIHRoZSBzZXNzaW9uIGRhZW1v
biBieQpsYXVuY2hpbmcgaXQgd2l0aCB0aGUgJy12dnYnIHN3aXRjaC4KQWxzbywgcGxlYXNlIGNo
ZWNrIHRoYXQgeW91ciBsdHRuZy1tb2R1bGVzIHZlcnNpb24gbWF0Y2hlcyB0aGUgcmVzdCBvZgp0
aGUgdG9vbGNoYWluICh2Mi43LngpCgpUaGFua3MhCkrDqXLDqW1pZQoKPgo+IENoZWVycyEKPgo+
Cj4gT24gMjAxNS0xMS0xMCAwMzoxNyBBTSwgemhlbnl1LnJlbiB3cm90ZToKPj4KPj4gSGksZGV2
LXRlYW0KPj4KPj4gICAgSSBnb3QgdGhlIGZvbGxvd2luZyBlcnJvcyB3aGVuIEkgcnVuIHRoZSBj
b21tZCA6bHR0bmcgZW5hYmxlLWV2ZW50IC1rCj4+IC1hCj4+ICJFcnJvcjogRXZlbnRzOiBFbmFi
bGUga2VybmVsIGV2ZW50IGZhaWxlZCAoY2hhbm5lbCBjaGFubmVsMCwgc2Vzc2lvbgo+PiBrZXJu
ZWxfdGVzdCkKPj4gRXJyb3I6IENvbW1hbmQgZXJyb3IiCj4+ICAgSXQgc2VlbXMgdGhhdCBMVFRO
Ry0yLjcuMCBkbyBOT1Qgc3VwcG9ydCBlbmFibGUtZXZlbnQgb3B0aW9uICItLWFsbCIuIElzCj4+
IHRoYXQgcmlnaHQ/SWYgd28gLHdoYXQncyB0aGUgaWRlYSBiZWhpbmQgaXQ/Cj4+Cj4+IFRoYW5r
cwo+PiB6aGVueXUucmVuCj4+Cj4+Cj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPj4gbHR0bmctZGV2
QGxpc3RzLmx0dG5nLm9yZwo+PiBodHRwOi8vbGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1h
bi9saXN0aW5mby9sdHRuZy1kZXYKPgo+Cj4gLS0KPiBKb25hdGhhbiBSLiBKdWxpZW4KPiBFZmZp
Y2lvcwo+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IGx0dG5nLWRldiBtYWlsaW5nIGxpc3QKPiBsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCj4g
aHR0cDovL2xpc3RzLmx0dG5nLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2
CgoKCi0tIApKw6lyw6ltaWUgR2FsYXJuZWF1CkVmZmljaU9TIEluYy4KaHR0cDovL3d3dy5lZmZp
Y2lvcy5jb20KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Cmx0dG5nLWRldiBtYWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwOi8v
bGlzdHMubHR0bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK
