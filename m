From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: Printing bit fields with LTTng
Date: Wed, 10 Jun 2015 17:28:42 -0400
Message-ID: <CAFXXi0k-HfWxPVmmF8=nap20pS-HRQwWwMc0P8jj0-RRhjXkYw__22233.3071790219$1433971818$gmane$org@mail.gmail.com>
References: <CAL1ZhON=nEPuoXks2AKq4k7nCpK_W_FQ96TM3299V69V6RgW_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1Z2nYi-0007Fb-8T
 for lttng-dev@lists.lttng.org; Wed, 10 Jun 2015 17:29:18 -0400
Received: by iebps5 with SMTP id ps5so4018615ieb.3
 for <lttng-dev@lists.lttng.org>; Wed, 10 Jun 2015 14:29:13 -0700 (PDT)
In-Reply-To: <CAL1ZhON=nEPuoXks2AKq4k7nCpK_W_FQ96TM3299V69V6RgW_w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Chidhu R <chid1989@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

T24gMTAgSnVuZSAyMDE1IGF0IDE3OjE2LCBDaGlkaHUgUiA8Y2hpZDE5ODlAZ21haWwuY29tPiB3
cm90ZToKPiBIZWxsbywKPgo+IEkgYW0gZ2V0dGluZyBjb21waWxhdGlvbiBpc3N1ZXMgd2hpbGUg
dHJ5aW5nIHRvIHByaW50IGJpdCBmaWVsZCB2YWx1ZXMgd2l0aAo+IExUVG5nLgo+Cj4gRXJyb3I6
Cj4KPiBoZWxsby5jOiBJbiBmdW5jdGlvbiDigJhtYWlu4oCZOgo+IGhlbGxvLmM6MzY6MTogZXJy
b3I6IOKAmHR5cGVvZuKAmSBhcHBsaWVkIHRvIGEgYml0LWZpZWxkCj4gaGVsbG8uYzozNjoxOiBl
cnJvcjog4oCYdHlwZW9m4oCZIGFwcGxpZWQgdG8gYSBiaXQtZmllbGQKPiBoZWxsby5jOjM2OjE6
IGVycm9yOiDigJh0eXBlb2bigJkgYXBwbGllZCB0byBhIGJpdC1maWVsZAo+IGhlbGxvLmM6MzY6
MTogZXJyb3I6IOKAmHNpemVvZuKAmSBhcHBsaWVkIHRvIGEgYml0LWZpZWxkCj4KPiBTbmlwcGV0
Ogo+Cj4gc3RydWN0IGFiY3sKPiAgICAgICAgIGludCBhOjE2Owo+ICAgICAgICAgaW50IGI6ODsK
PiB9Owo+Cj4gTGluZSAzNjogdHJhY2Vwb2ludChoZWxsb193b3JsZCwgbXlfdGhpcmRfdHJhY2Vw
b2ludCwgYWEuYSwgIndlbGNvbWUiKTsKPiBMaW5lIDM3OiBwcmludGYoInZhbCA9ICV4XG4iLGFh
LmEpOwo+Cj4gdHJhY2Vwb2ludCBsaW5lIHJlc3VsdHMgaW4gY29tcGlsYXRpb24gZXJyb3IuCj4g
cHJpbnRmIHN1Y2NlZWRzLgo+Cj4gVHAgZGVmaW5pdGlvbiBsb29rcyBsaWtlIHRoaXMuCj4KPiBU
UkFDRVBPSU5UX0VWRU5UKAo+ICAgICBoZWxsb193b3JsZCwKPiAgICAgbXlfdGhpcmRfdHJhY2Vw
b2ludCwKPiAgICAgVFBfQVJHUygKPiAgICAgICAgIHVpbnQzMl90LCBhcmcsCj4gICAgICAgICBj
b25zdCBjaGFyICogLCBteV9zdHJpbmdfYXJnCj4gICAgICksCj4gICAgIFRQX0ZJRUxEUygKPiAg
ICAgICAgIGN0Zl9pbnRlZ2VyX2hleCh1aW50MzJfdCwgbXlfYXJnLCBhcmcpCj4gICAgICAgICBj
dGZfc3RyaW5nKGZpZWxkLCBteV9zdHJpbmdfYXJnKQo+ICAgICApCj4gKQo+Cj4gSG93IHRvIHBy
aW50IGJpdCBmaWVsZCB2YWx1ZXM/Cj4KPiBUaGFua3MKPiBDaGlkCgpJIGhhdmUgbm8gaWRlYSB3
aGF0IHRoZSByaWdodCBmaXggd291bGQgYmUsIGJ1dCBhbiBlYXN5IHdvcmthcm91bmQKY291bGQg
YmUgdG8gYWRkIDAgdG8geW91ciB2YWx1ZToKCiAgICB0cmFjZXBvaW50KGhlbGxvX3dvcmxkLCBt
eV90aGlyZF90cmFjZXBvaW50LCBhYS5hICsgMCwgIndlbGNvbWUiKTsKCkkganVzdCB0cmllZCBp
dCBhbmQgaXQgd29ya3MuCgpTaW1vbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbHR0bmctZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0
bmcub3JnCmh0dHA6Ly9saXN0cy5sdHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0
dG5nLWRldgo=
