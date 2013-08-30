From: Gianluca Borello <g.borello@gmail.com>
Subject: Tracepoints overhead in x86_64
Date: Fri, 30 Aug 2013 14:47:52 -0700
Message-ID: <CAJWsiu=og9Xnt4m31e1KGqDnEaCq9QWe8HnW5RE4foh4KCo5XA__17072.8155565032$1377899378$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e011827ae0c7f1804e5312f21
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <g.borello@gmail.com>) id 1VFWYZ-00048n-00
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 17:48:44 -0400
Received: by mail-lb0-f172.google.com with SMTP id x18so2320945lbi.17
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 14:48:32 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--089e011827ae0c7f1804e5312f21
Content-Type: multipart/alternative; boundary=089e011827ae0c7f1404e5312f1f

--089e011827ae0c7f1404e5312f1f
Content-Type: text/plain; charset=UTF-8

Hello,

This question is more focused on tracepoints rather than LTTng, so feel
free to point me at LKML if I'm too off topic.

I am looking for a way to trace all the system call activity 24/7 (and do
some very customized processing, so LTTng doesn't fit very well in the
picture), and I have the specific requirement that the overhead must be
extremely slow, even in the worst case.

Being a LTTng user myself, I figured tracepoints would be the first natural
choice, so what I did was writing a small kernel module that does nothing
but registering an empty probe for "sys_enter" and "sys_exit", and I am a
bit concerned about the results that I obtained on my Intel Core i3 running
linux 3.8.0.

Basically this is my worst case:

while(1)
{
close(5000);
}

I let this run for 10 seconds, and these are the numbers that I get:

- without tracepoints: 13.1M close/s
- with tracepoints: 4.1M close/s

The overhead is far from being negligible, and digging into the problem it
seems like when the tracepoints are enabled, the system doesn't go through
the "system_call_fastpath" (in arch/x86/kernel/entry_64.S), using IRET
instead of SYSRET (A relevant commit seems this:
https://github.com/torvalds/linux/commit/7bf36bbc5e0c09271f9efe22162f8cc3f8ebd3d2
).

This is the first time I look into these things so understanding the logic
behind is pretty hard for me, but I managed to write a quick and dirty hack
that just forces a call to "trace_sys_enter" and "trace_sys_exit" in the
fast path (you can find the patch attached, I didn't have a lot of time to
spend on this so it's pretty inefficient because I do a bunch of
instructions even if the tracepoints are not enabled and there are obvious
bugs if the ptrace code gets enabled, but it proves my point) and these are
the results:

- without tracepoints (patched kernel): 11.5M close()/s
- with tracepoints (patched kernel): 9.6M close()/s

Of course my benchmark is an extreme situation, but measuring in a more
realistic scenario (using apache ab to stress a nginx server) I can still
notice a difference:

- without tracepoints: 16K HTTP requests/s
- with tracepoints: 15.1K HTTP requests/s
- without tracepoints (patched kernel): 16K HTTP requests/s
- with tracepoints (patched kernel): 15.8K HTTP requests/s

It's a real 6% vs 1% worst case overhead when using an intense server
application, and that doesn't count the cost of executing the body of the
probes themselves.

Has anyone ever faced this before? Am I just inexperienced with the topic
and stating the obvious? Are there any suggestions or documentation I
should look at?

Thank you for your help and for the amazing work on LTTng.

--089e011827ae0c7f1404e5312f1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,<br></div><div><br></div><div>This question is =
more focused on tracepoints rather than LTTng, so feel free to point me at =
LKML if I&#39;m too off topic.</div><div><br></div><div>I am looking for a =
way to trace all the system call activity 24/7 (and do some very customized=
 processing, so LTTng doesn&#39;t fit very well in the picture), and I have=
 the specific requirement that the overhead must be extremely slow, even in=
 the worst case.</div>


<div><br></div><div>Being a LTTng user myself, I figured tracepoints would =
be the first natural choice, so what I did was writing a small kernel modul=
e that does nothing but registering an empty probe for &quot;sys_enter&quot=
; and &quot;sys_exit&quot;, and I am a bit concerned about the results that=
 I obtained on my Intel Core i3 running linux 3.8.0.</div>


<div><br></div><div>Basically this is my worst case:</div><div><br></div><d=
iv>while(1)</div><div>{</div><div><span style=3D"white-space:pre-wrap">	</s=
pan>close(5000);</div><div>}</div><div><br></div><div>I let this run for 10=
 seconds, and these are the numbers that I get:</div>


<div><br></div><div>- without tracepoints: 13.1M close/s</div><div>- with t=
racepoints: 4.1M close/s</div><div><br></div><div>The overhead is far from =
being negligible, and digging into the problem it seems like when the trace=
points are enabled, the system doesn&#39;t go through the &quot;system_call=
_fastpath&quot; (in arch/x86/kernel/entry_64.S), using IRET instead of SYSR=
ET (A relevant commit seems this: <a href=3D"https://github.com/torvalds/li=
nux/commit/7bf36bbc5e0c09271f9efe22162f8cc3f8ebd3d2" target=3D"_blank">http=
s://github.com/torvalds/linux/commit/7bf36bbc5e0c09271f9efe22162f8cc3f8ebd3=
d2</a>).</div>


<div><br></div><div>This is the first time I look into these things so unde=
rstanding the logic behind is pretty hard for me, but I managed to write a =
quick and dirty hack that just forces a call to &quot;trace_sys_enter&quot;=
 and &quot;trace_sys_exit&quot; in the fast path (you can find the patch at=
tached, I didn&#39;t have a lot of time to spend on this so it&#39;s pretty=
 inefficient because I do a bunch of instructions even if the tracepoints a=
re not enabled and there are obvious bugs if the ptrace code gets enabled, =
but it proves my point) and these are the results:</div>


<div><br></div><div>- without tracepoints (patched kernel): 11.5M close()/s=
</div><div>- with tracepoints (patched kernel): 9.6M close()/s</div><div><b=
r></div><div>Of course my benchmark is an extreme situation, but measuring =
in a more realistic scenario (using apache ab to stress a nginx server) I c=
an still notice a difference:</div>


<div><br></div><div>- without tracepoints: 16K HTTP requests/s</div><div>- =
with tracepoints: 15.1K HTTP requests/s</div><div>- without tracepoints (pa=
tched kernel): 16K HTTP requests/s</div><div>- with tracepoints (patched ke=
rnel): 15.8K HTTP requests/s</div>


<div><br></div><div>It&#39;s a real 6% vs 1% worst case overhead when using=
 an intense server application, and that doesn&#39;t count the cost of exec=
uting the body of the probes themselves.</div><div><br></div><div>Has anyon=
e ever faced this before? Am I just inexperienced with the topic and statin=
g the obvious? Are there any suggestions or documentation I should look at?=
</div>


<div><br></div><div>Thank you for your help and for the amazing work on LTT=
ng.</div><div><br></div></div>

--089e011827ae0c7f1404e5312f1f--

--089e011827ae0c7f1804e5312f21
Content-Type: application/octet-stream;
	name="tracepoints_fast_syscall_path.patch"
Content-Disposition: attachment;
	filename="tracepoints_fast_syscall_path.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hkzx9i6m0

ZGlmZiAtdXByTiBsaW51eC1zb3VyY2UtMy44LjAub3JpZy9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90
aHJlYWRfaW5mby5oIGxpbnV4LXNvdXJjZS0zLjguMC9hcmNoL3g4Ni9pbmNsdWRlL2FzbS90aHJl
YWRfaW5mby5oCi0tLSBsaW51eC1zb3VyY2UtMy44LjAub3JpZy9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS90aHJlYWRfaW5mby5oCTIwMTMtMDItMTggMTU6NTg6MzQuMDAwMDAwMDAwIC0wODAwCisrKyBs
aW51eC1zb3VyY2UtMy44LjAvYXJjaC94ODYvaW5jbHVkZS9hc20vdGhyZWFkX2luZm8uaAkyMDEz
LTA4LTMwIDA4OjM1OjQ5Ljc4NTYxMDYxMSAtMDcwMApAQCAtMTE5LDIwICsxMTksMTkgQEAgc3Ry
dWN0IHRocmVhZF9pbmZvIHsKICNkZWZpbmUgX1RJRl9GT1JDRURfVEYJCSgxIDw8IFRJRl9GT1JD
RURfVEYpCiAjZGVmaW5lIF9USUZfQkxPQ0tTVEVQCQkoMSA8PCBUSUZfQkxPQ0tTVEVQKQogI2Rl
ZmluZSBfVElGX0xBWllfTU1VX1VQREFURVMJKDEgPDwgVElGX0xBWllfTU1VX1VQREFURVMpCi0j
ZGVmaW5lIF9USUZfU1lTQ0FMTF9UUkFDRVBPSU5UCSgxIDw8IFRJRl9TWVNDQUxMX1RSQUNFUE9J
TlQpCiAjZGVmaW5lIF9USUZfQUREUjMyCQkoMSA8PCBUSUZfQUREUjMyKQogI2RlZmluZSBfVElG
X1gzMgkJKDEgPDwgVElGX1gzMikKIAogLyogd29yayB0byBkbyBpbiBzeXNjYWxsX3RyYWNlX2Vu
dGVyKCkgKi8KICNkZWZpbmUgX1RJRl9XT1JLX1NZU0NBTExfRU5UUlkJXAogCShfVElGX1NZU0NB
TExfVFJBQ0UgfCBfVElGX1NZU0NBTExfRU1VIHwgX1RJRl9TWVNDQUxMX0FVRElUIHwJXAotCSBf
VElGX1NFQ0NPTVAgfCBfVElGX1NJTkdMRVNURVAgfCBfVElGX1NZU0NBTExfVFJBQ0VQT0lOVCB8
CVwKKwkgX1RJRl9TRUNDT01QIHwgX1RJRl9TSU5HTEVTVEVQIHwJXAogCSBfVElGX05PSFopCiAK
IC8qIHdvcmsgdG8gZG8gaW4gc3lzY2FsbF90cmFjZV9sZWF2ZSgpICovCiAjZGVmaW5lIF9USUZf
V09SS19TWVNDQUxMX0VYSVQJXAogCShfVElGX1NZU0NBTExfVFJBQ0UgfCBfVElGX1NZU0NBTExf
QVVESVQgfCBfVElGX1NJTkdMRVNURVAgfAlcCi0JIF9USUZfU1lTQ0FMTF9UUkFDRVBPSU5UIHwg
X1RJRl9OT0haKQorCSBfVElGX05PSFopCiAKIC8qIHdvcmsgdG8gZG8gb24gaW50ZXJydXB0L2V4
Y2VwdGlvbiByZXR1cm4gKi8KICNkZWZpbmUgX1RJRl9XT1JLX01BU0sJCQkJCQkJXApAQCAtMTQy
LDcgKzE0MSw3IEBAIHN0cnVjdCB0aHJlYWRfaW5mbyB7CiAKIC8qIHdvcmsgdG8gZG8gb24gYW55
IHJldHVybiB0byB1c2VyIHNwYWNlICovCiAjZGVmaW5lIF9USUZfQUxMV09SS19NQVNLCQkJCQkJ
XAotCSgoMHgwMDAwRkZGRiAmIH5fVElGX1NFQ0NPTVApIHwgX1RJRl9TWVNDQUxMX1RSQUNFUE9J
TlQgfAlcCisJKCgweDAwMDBGRkZGICYgfl9USUZfU0VDQ09NUCkgfCAJXAogCV9USUZfTk9IWikK
IAogLyogT25seSB1c2VkIGZvciA2NCBiaXQgKi8KZGlmZiAtdXByTiBsaW51eC1zb3VyY2UtMy44
LjAub3JpZy9hcmNoL3g4Ni9rZXJuZWwvZW50cnlfNjQuUyBsaW51eC1zb3VyY2UtMy44LjAvYXJj
aC94ODYva2VybmVsL2VudHJ5XzY0LlMKLS0tIGxpbnV4LXNvdXJjZS0zLjguMC5vcmlnL2FyY2gv
eDg2L2tlcm5lbC9lbnRyeV82NC5TCTIwMTMtMDItMTggMTU6NTg6MzQuMDAwMDAwMDAwIC0wODAw
CisrKyBsaW51eC1zb3VyY2UtMy44LjAvYXJjaC94ODYva2VybmVsL2VudHJ5XzY0LlMJMjAxMy0w
OC0zMCAxMDo1MjoyNy43MzI0MDM2MTcgLTA3MDAKQEAgLTYzMyw2ICs2MzMsMTIgQEAgR0xPQkFM
KHN5c3RlbV9jYWxsX2FmdGVyX3N3YXBncykKIAl0ZXN0bCAkX1RJRl9XT1JLX1NZU0NBTExfRU5U
UlksVElfZmxhZ3MrVEhSRUFEX0lORk8oJXJzcCxSSVAtQVJHT0ZGU0VUKQogCWpueiB0cmFjZXN5
cwogc3lzdGVtX2NhbGxfZmFzdHBhdGg6CisJU0FWRV9SRVNUCisJRklYVVBfVE9QX09GX1NUQUNL
ICVyZGkKKwltb3ZxICVyc3AsJXJkaQorCWNhbGwgc3lzY2FsbF90cmFjZXBvaW50X2VudGVyIAor
CUxPQURfQVJHUyBBUkdPRkZTRVQsIDAKKwlSRVNUT1JFX1JFU1QKICNpZiBfX1NZU0NBTExfTUFT
SyA9PSB+MAogCWNtcHEgJF9fTlJfc3lzY2FsbF9tYXgsJXJheAogI2Vsc2UKQEAgLTY0OCw2ICs2
NTQsMTIgQEAgc3lzdGVtX2NhbGxfZmFzdHBhdGg6CiAgKiBIYXMgaW5jb21wbGV0ZSBzdGFjayBm
cmFtZSBhbmQgdW5kZWZpbmVkIHRvcCBvZiBzdGFjay4KICAqLwogcmV0X2Zyb21fc3lzX2NhbGw6
CisJU0FWRV9SRVNUCisJcHVzaHFfY2ZpICVyZGkKKwlsZWFxIDgoJXJzcCksJXJkaQkjICZwdHJl
Z3MgLT4gYXJnMQorCWNhbGwgc3lzY2FsbF90cmFjZV9sZWF2ZQorCXBvcHFfY2ZpICVyZGkKKwlS
RVNUT1JFX1JFU1QKIAltb3ZsICRfVElGX0FMTFdPUktfTUFTSywlZWRpCiAJLyogZWRpOglmbGFn
bWFzayAqLwogc3lzcmV0X2NoZWNrOgpkaWZmIC11cHJOIGxpbnV4LXNvdXJjZS0zLjguMC5vcmln
L2FyY2gveDg2L2tlcm5lbC9wdHJhY2UuYyBsaW51eC1zb3VyY2UtMy44LjAvYXJjaC94ODYva2Vy
bmVsL3B0cmFjZS5jCi0tLSBsaW51eC1zb3VyY2UtMy44LjAub3JpZy9hcmNoL3g4Ni9rZXJuZWwv
cHRyYWNlLmMJMjAxMy0wMi0xOCAxNTo1ODozNC4wMDAwMDAwMDAgLTA4MDAKKysrIGxpbnV4LXNv
dXJjZS0zLjguMC9hcmNoL3g4Ni9rZXJuZWwvcHRyYWNlLmMJMjAxMy0wOC0zMCAxMDozMDowOC4y
MTcwNzI4NDUgLTA3MDAKQEAgLTE1NjcsMyArMTU2NywxNiBAQCB2b2lkIHN5c2NhbGxfdHJhY2Vf
bGVhdmUoc3RydWN0IHB0X3JlZ3MKIAogCXVzZXJfZW50ZXIoKTsKIH0KKwordm9pZCBzeXNjYWxs
X3RyYWNlcG9pbnRfZW50ZXIoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCit7CisJaWYgKHVubGlrZWx5
KHRlc3RfdGhyZWFkX2ZsYWcoVElGX1NZU0NBTExfVFJBQ0VQT0lOVCkpKQorCQl0cmFjZV9zeXNf
ZW50ZXIocmVncywgcmVncy0+b3JpZ19heCk7Cit9CisKK3ZvaWQgc3lzY2FsbF90cmFjZXBvaW50
X2xlYXZlKHN0cnVjdCBwdF9yZWdzICpyZWdzKQoreworCWlmICh1bmxpa2VseSh0ZXN0X3RocmVh
ZF9mbGFnKFRJRl9TWVNDQUxMX1RSQUNFUE9JTlQpKSkKKwkJdHJhY2Vfc3lzX2V4aXQocmVncywg
cmVncy0+YXgpOworfQorCg==
--089e011827ae0c7f1804e5312f21
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--089e011827ae0c7f1804e5312f21--
