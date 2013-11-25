From: Zifei Tong <soariez@gmail.com>
Subject: Build and test LTTng on Travis CI
Date: Mon, 25 Nov 2013 23:21:30 +0800
Message-ID: <CAJ7wx-ER0ZaaGnCbyYzh95oS=8NG_QNy_wdX9PhUjEcRxQJ+dw__20691.6823670783$1385392998$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <soariez@gmail.com>) id 1VkxzM-0001AS-8h
	for lttng-dev@lists.lttng.org; Mon, 25 Nov 2013 10:22:22 -0500
Received: by mail-vc0-f180.google.com with SMTP id if17so2926191vcb.11
	for <lttng-dev@lists.lttng.org>; Mon, 25 Nov 2013 07:22:10 -0800 (PST)
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

SGksCgpJIGp1c3QgbWFkZSBhIHRyYXZpcyBzY3JpcHQgWzFdIHRvIGJ1aWxkIGFuZCB0ZXN0IExU
VG5nIG9uIFRyYXZpcyBDSS4KSSB0aGluayB0aGlzIG1pZ2h0IGJlIHVzZWZ1bCBpbiBjYXNlIHlv
dSB3b3JrIG9uIHlvdXIgb3duIGx0dG5nIGZvcmsKYW5kIHdhbnQgdG8gaGF2ZSBhIENJIHN5c3Rl
bSB0byBjaGVjayB5b3VyIGNvbW1pdHMuCgpUaGUgbHR0bmcgdGVzdCBzdWl0ZSBydW5zIGdvb2Qg
d2l0aCBnY2Mgb24gVHJhdmlzIENJIFsyXSwgd2l0aCBtaW5vcgpjaGFuZ2VzIFs0XSB3aXRoIHJl
c3BlY3QgdG8gYnVnICM2NjYgWzVdIGFuZCB0aGUgNTAgbWludXRlcyBidWlsZCB0aW1lCmxpbWl0
IG9mIFRyYXZpcyBDSS4KCkhvd2V2ZXIgZm9yIGNsYW5nIGJ1aWxkIFszXSwgdGhlIHVuaXQgdGVz
dHMgd29uJ3QgcGFzcy4gQW5kIEkgY2FuCmNvbmZpcm0gdGhpcyBmYWlsdXJlIG9uIG15IG93biBt
YWNoaW5lLiBJJ3ZlIGNyZWF0ZWQgIzY5NyBbNl0gb24gYnVnCnRyYWNrZXIgd2l0aCBmdWxsIGJh
Y2t0cmFjZXMuCgpUaGFua3MgIQoKWzFdIGh0dHBzOi8vcmF3LmdpdGh1Yi5jb20vNWtnL2x0dG5n
LXRvb2xzL3RyYXZpcy1jaS8udHJhdmlzLnltbApbMl0gaHR0cHM6Ly90cmF2aXMtY2kub3JnLzVr
Zy9sdHRuZy10b29scy9qb2JzLzE0NDkwOTExClszXSBodHRwczovL3RyYXZpcy1jaS5vcmcvNWtn
L2x0dG5nLXRvb2xzL2pvYnMvMTQ0OTA5MTIKWzRdIGh0dHBzOi8vZ2l0aHViLmNvbS81a2cvbHR0
bmctdG9vbHMvY29tbWl0L2FmYWQ0NmEyZTc0OTdlN2RkNTEwMWYxNzBkZjI3OGY4ZGVkM2ExZjcK
WzVdIGh0dHBzOi8vYnVncy5sdHRuZy5vcmcvaXNzdWVzLzY2NgpbNl0gaHR0cHM6Ly9idWdzLmx0
dG5nLm9yZy9pc3N1ZXMvNjk3Ci0tCkJlc3QgUmVnYXJkcywK5Lud5a2Q6aOeIChaaWZlaSBUb25n
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmct
ZGV2IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHA6Ly9saXN0cy5s
dHRuZy5vcmcvY2dpLWJpbi9tYWlsbWFuL2xpc3RpbmZvL2x0dG5nLWRldgo=
