Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96883C41513
	for <lttng-dev@archiver.kernel.org>; Wed, 19 Jun 2024 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1718812359;
	bh=WDLIKjNn1j65hhzjOduW3Az6McFYwkDyjVij3U6tcrE=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=B6jwx/Gv13L9gP/q+3DfmfttJ7Zvu+G3asnEpy1mhTHNs+wQImoIHJxRorREnQo69
	 6jCTOsjvdHdHKbfBur0X/Gyu48XWm1qc54nw2LD9MF9/9D0pGZEMk+Ppa6eaFoUa48
	 QHIvLKWdUhfFpONYXzR7jZCmpWVnhl701opCqGgyok6o9I/ZrP38WLwT7v7tX5jnzy
	 rbyaR0+CZeQOcSCrYO6yDFg0IPnDa4Sjoj5mn9UgmjT0QPs6K7xGQg92gazw4htAGH
	 ZCGIj+g/EGV6V3kBPfwJMoSRXnr2WIEf8z9YgQejuMczRuuJv/ox60xHbingIpdlMb
	 6WnBqolehElgg==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4W47Rp4DxDz4fh;
	Wed, 19 Jun 2024 11:52:38 -0400 (EDT)
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
 by lists.lttng.org (Postfix) with ESMTPS id 4W47Rn4TxGz4XL
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2024 11:52:37 -0400 (EDT)
Received: from zimbra-s2.polymtl.ca (zimbra-s2.polymtl.ca [132.207.23.204])
 by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 45JFfuQg078754;
 Wed, 19 Jun 2024 11:41:57 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 45JFfuQg078754
Date: Wed, 19 Jun 2024 11:41:56 -0400 (EDT)
To: lttng-dev@lists.lttng.org
Message-ID: <364622686.75839325.1718811716721.JavaMail.zimbra@polymtl.ca>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
 boundary="----=_Part_75839321_2114178019.1718811716718"
X-Originating-IP: [132.207.169.227]
X-Mailer: Zimbra 9.0.0_GA_4583 (ZimbraWebClient - GC126 (Win)/9.0.0_GA_4583)
Thread-Index: CVL1bwIDCF2cZxPJrOj3/EsJzfkdOg==
Thread-Topic: Compile modules on Centos Stream 9
X-Poly-FromMTA: (zimbra-s2.polymtl.ca [132.207.23.204]) at Wed,
 19 Jun 2024 15:41:56 +0000
Subject: [lttng-dev] Compile modules on Centos Stream 9
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Jean-Marc Chevalier via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Jean-Marc Chevalier <jean-marc.chevalier@polymtl.ca>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

------=_Part_75839321_2114178019.1718811716718
Content-Type: multipart/alternative; 
	boundary="=_88fe1f91-8011-48da-98cf-d2a02de418d3"

--=_88fe1f91-8011-48da-98cf-d2a02de418d3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Is it possible to build the lttng modules againt Centos Stream 9 kernels? I=
 see these warnings at the top when attempting to compile:=20

make[1]: Entering directory '/usr/src/kernels/5.14.0-452.el9.x86_64'=20
/home/tmp/git/lttng-modules/src/probes/Kbuild:28: File ./mm/slab.h not foun=
d. Probe "kmem" is disabled. Use full kernel source tree to enable it.=20
/home/tmp/git/lttng-modules/src/probes/Kbuild:79: File ./arch/x86/kvm/lapic=
.h not found. Probe "kvm" x86-specific is disabled. Use full kernel source =
tree to enable it.=20
/home/tmp/git/lttng-modules/src/probes/Kbuild:181: Files ./mm/internal.h no=
t found. Probe "compaction" is disabled. Use full kernel source tree to ena=
ble it.=20
/home/tmp/git/lttng-modules/src/probes/Kbuild:190: Files ./fs/ext4/*.h not =
found. Probe "ext4" is disabled. Use full kernel source tree to enable it.=
=20
/home/tmp/git/lttng-modules/src/probes/Kbuild:213: File ./drivers/base/regm=
ap/trace.h not found. Probe "regmap" is disabled. Use full kernel source tr=
ee to enable it.=20

I tried with module versions 2.12.17 and 2.13.13 against the kernel 5.14.0-=
452.el9.x86_64 and I obtain this error:=20

/home/tmp/git/lttng-modules/src/probes/../../include/lttng/tracepoint-event=
-impl.h:133:6: error: conflicting types for 'trace_sched_stat_runtime'; hav=
e 'void(struct task_struct *, u64, u64)' {aka 'void(struct task_struct *, l=
ong long unsigned int, long long unsigned int)'}=20

Any help would be greatly appreciated.=20

- JM=20

--=20
- Jean-Marc Chevalier=20
Technicien=20
G=C3=A9nie informatique G=C3=A9nie logiciel=20
Local: M-4002=20
T=C3=A9l=C3=A9phone: 514-340-4711 x4266=20

--=_88fe1f91-8011-48da-98cf-d2a02de418d3
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div>Hi,</div><div><br data-mce-bogus=3D"1"></di=
v><div>Is it possible to build the lttng modules againt Centos Stream 9 ker=
nels? I see these warnings at the top when attempting to compile:</div><div=
><br data-mce-bogus=3D"1"></div><div><div>make[1]: Entering directory '/usr=
/src/kernels/5.14.0-452.el9.x86_64'</div><div>/home/tmp/git/lttng-modules/s=
rc/probes/Kbuild:28: File ./mm/slab.h not found. Probe "kmem" is disabled. =
Use full kernel source tree to enable it.</div><div>/home/tmp/git/lttng-mod=
ules/src/probes/Kbuild:79: File ./arch/x86/kvm/lapic.h not found. Probe "kv=
m" x86-specific is disabled. Use full kernel source tree to enable it.</div=
><div>/home/tmp/git/lttng-modules/src/probes/Kbuild:181: Files ./mm/interna=
l.h not found. Probe "compaction" is disabled. Use full kernel source tree =
to enable it.</div><div>/home/tmp/git/lttng-modules/src/probes/Kbuild:190: =
Files ./fs/ext4/*.h not found. Probe "ext4" is disabled. Use full kernel so=
urce tree to enable it.</div><div>/home/tmp/git/lttng-modules/src/probes/Kb=
uild:213: File ./drivers/base/regmap/trace.h not found. Probe "regmap" is d=
isabled. Use full kernel source tree to enable it.</div></div><div><br data=
-mce-bogus=3D"1"></div><div>I tried with module versions 2.12.17 and 2.13.1=
3 against the kernel 5.14.0-452.el9.x86_64 and I obtain this error:</div><d=
iv><br data-mce-bogus=3D"1"></div><div>/home/tmp/git/lttng-modules/src/prob=
es/../../include/lttng/tracepoint-event-impl.h:133:6: error: conflicting ty=
pes for 'trace_sched_stat_runtime'; have 'void(struct task_struct *, u64,&n=
bsp; u64)' {aka 'void(struct task_struct *, long long unsigned int,&nbsp; l=
ong long unsigned int)'}<br data-mce-bogus=3D"1"></div><div><br data-mce-bo=
gus=3D"1"></div><div>Any help would be greatly appreciated.</div><div><br d=
ata-mce-bogus=3D"1"></div><div>- JM</div><div><br></div><div data-marker=3D=
"__SIG_PRE__">-- <br>- Jean-Marc Chevalier<br>&nbsp;&nbsp;Technicien<br>&nb=
sp;&nbsp;G=C3=A9nie informatique G=C3=A9nie logiciel<br>&nbsp;&nbsp;Local: =
&nbsp; &nbsp; M-4002&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>&nb=
sp;&nbsp;T=C3=A9l=C3=A9phone: 514-340-4711 x4266<br></div></div></body></ht=
ml>
--=_88fe1f91-8011-48da-98cf-d2a02de418d3--

------=_Part_75839321_2114178019.1718811716718
Content-Type: text/plain; name=make-lttng-2-13-13.txt
Content-Disposition: attachment; filename=make-lttng-2-13-13.txt
Content-Transfer-Encoding: base64

bWFrZSAtQyAvbGliL21vZHVsZXMvNS4xNC4wLTQ1Mi5lbDkueDg2XzY0L2J1aWxkIE09L2hvbWUv
dG1wL2x0dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMgXA0KCUNPTkZJR19MVFRORz1tIENPTkZJR19M
VFROR19DTE9DS19QTFVHSU5fVEVTVD1tIFwNCglLQ1BQRkxBR1M9JycgXA0KCW1vZHVsZXMNCm1h
a2VbMV06IEVudGVyaW5nIGRpcmVjdG9yeSAnL3Vzci9zcmMva2VybmVscy81LjE0LjAtNDUyLmVs
OS54ODZfNjQnDQovaG9tZS90bXAvbHR0bmctbW9kdWxlcy0yLjEzLjEzL3NyYy9wcm9iZXMvS2J1
aWxkOjI4OiBGaWxlIC4vbW0vc2xhYi5oIG5vdCBmb3VuZC4gUHJvYmUgImttZW0iIGlzIGRpc2Fi
bGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl0Lg0KL2hvbWUvdG1w
L2x0dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMvcHJvYmVzL0tidWlsZDo4MzogRmlsZSAuL2FyY2gv
eDg2L2t2bS9sYXBpYy5oIG5vdCBmb3VuZC4gUHJvYmUgImt2bSIgeDg2LXNwZWNpZmljIGlzIGRp
c2FibGVkLiBVc2UgZnVsbCBrZXJuZWwgc291cmNlIHRyZWUgdG8gZW5hYmxlIGl0Lg0KL2hvbWUv
dG1wL2x0dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMvcHJvYmVzL0tidWlsZDoyMTA6IEZpbGVzIC4v
bW0vaW50ZXJuYWwuaCBub3QgZm91bmQuIFByb2JlICJjb21wYWN0aW9uIiBpcyBkaXNhYmxlZC4g
VXNlIGZ1bGwga2VybmVsIHNvdXJjZSB0cmVlIHRvIGVuYWJsZSBpdC4NCi9ob21lL3RtcC9sdHRu
Zy1tb2R1bGVzLTIuMTMuMTMvc3JjL3Byb2Jlcy9LYnVpbGQ6MjE5OiBGaWxlcyAuL2ZzL2V4dDQv
Ki5oIG5vdCBmb3VuZC4gUHJvYmUgImV4dDQiIGlzIGRpc2FibGVkLiBVc2UgZnVsbCBrZXJuZWwg
c291cmNlIHRyZWUgdG8gZW5hYmxlIGl0Lg0KL2hvbWUvdG1wL2x0dG5nLW1vZHVsZXMtMi4xMy4x
My9zcmMvcHJvYmVzL0tidWlsZDoyNDg6IEZpbGUgLi9kcml2ZXJzL2Jhc2UvcmVnbWFwL3RyYWNl
Lmggbm90IGZvdW5kLiBQcm9iZSAicmVnbWFwIiBpcyBkaXNhYmxlZC4gTmVlZCBMaW51eCA0LjEr
IGtlcm5lbCBzb3VyY2UgdHJlZSB0byBlbmFibGUgaXQuDQogIENDIFtNXSAgL2hvbWUvdG1wL2x0
dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMvcHJvYmVzL2x0dG5nLXByb2JlLXNjaGVkLm8NCkluIGZp
bGUgaW5jbHVkZWQgZnJvbSAvaG9tZS90bXAvbHR0bmctbW9kdWxlcy0yLjEzLjEzL3NyYy9wcm9i
ZXMvLi4vLi4vaW5jbHVkZS9sdHRuZy9kZWZpbmVfdHJhY2UuaDo4NywNCiAgICAgICAgICAgICAg
ICAgZnJvbSAvaG9tZS90bXAvbHR0bmctbW9kdWxlcy0yLjEzLjEzL3NyYy9wcm9iZXMvLi4vLi4v
aW5jbHVkZS9pbnN0cnVtZW50YXRpb24vZXZlbnRzL3NjaGVkLmg6NzI5LA0KICAgICAgICAgICAg
ICAgICBmcm9tIC9ob21lL3RtcC9sdHRuZy1tb2R1bGVzLTIuMTMuMTMvc3JjL3Byb2Jlcy9sdHRu
Zy1wcm9iZS1zY2hlZC5jOjI4Og0KL2hvbWUvdG1wL2x0dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMv
cHJvYmVzLy4uLy4uL2luY2x1ZGUvbHR0bmcvdHJhY2Vwb2ludC1ldmVudC1pbXBsLmg6MTMzOjY6
IGVycm9yOiBjb25mbGljdGluZyB0eXBlcyBmb3IgJ3RyYWNlX3NjaGVkX3N0YXRfcnVudGltZSc7
IGhhdmUgJ3ZvaWQoc3RydWN0IHRhc2tfc3RydWN0ICosIHU2NCwgIHU2NCknIHtha2EgJ3ZvaWQo
c3RydWN0IHRhc2tfc3RydWN0ICosIGxvbmcgbG9uZyB1bnNpZ25lZCBpbnQsICBsb25nIGxvbmcg
dW5zaWduZWQgaW50KSd9DQogIDEzMyB8IHZvaWQgdHJhY2VfIyNfbmFtZShfcHJvdG8pOw0KICAg
ICAgfCAgICAgIF5+fn5+fg0KL2hvbWUvdG1wL2x0dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMvcHJv
YmVzLy4uLy4uL2luY2x1ZGUvbHR0bmcvdHJhY2Vwb2ludC1ldmVudC1pbXBsLmg6NDU6OTogbm90
ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdMVFROR19UUkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNF
X01BUCcNCiAgIDQ1IHwgICAgICAgICBMVFROR19UUkFDRVBPSU5UX0VWRU5UX0lOU1RBTkNFX01B
UChtYXAsIG5hbWUsIG1hcCwgUEFSQU1TKHByb3RvKSwgUEFSQU1TKGFyZ3MpKQ0KICAgICAgfCAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQovaG9tZS90bXAvbHR0
bmctbW9kdWxlcy0yLjEzLjEzL3NyYy9wcm9iZXMvLi4vLi4vaW5jbHVkZS9sdHRuZy90cmFjZXBv
aW50LWV2ZW50LWltcGwuaDo4Nzo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ0xUVE5H
X1RSQUNFUE9JTlRfRVZFTlRfTUFQJw0KICAgODcgfCAgICAgICAgIExUVE5HX1RSQUNFUE9JTlRf
RVZFTlRfTUFQKG5hbWUsIG5hbWUsICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICB8
ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCi9ob21lL3RtcC9sdHRuZy1tb2R1
bGVzLTIuMTMuMTMvc3JjL3Byb2Jlcy8uLi8uLi9pbmNsdWRlL2luc3RydW1lbnRhdGlvbi9ldmVu
dHMvc2NoZWQuaDo2NzE6MTogbm90ZTogaW4gZXhwYW5zaW9uIG9mIG1hY3JvICdMVFROR19UUkFD
RVBPSU5UX0VWRU5UJw0KICA2NzEgfCBMVFROR19UUkFDRVBPSU5UX0VWRU5UKHNjaGVkX3N0YXRf
cnVudGltZSwNCiAgICAgIHwgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIC4vaW5jbHVkZS90cmFjZS9ldmVudHMvc2NoZWQuaDoxMCwNCiAgICAgICAgICAgICAg
ICAgZnJvbSAvaG9tZS90bXAvbHR0bmctbW9kdWxlcy0yLjEzLjEzL3NyYy9wcm9iZXMvbHR0bmct
cHJvYmUtc2NoZWQuYzoxNzoNCi4vaW5jbHVkZS9saW51eC90cmFjZXBvaW50Lmg6MjU2OjI4OiBu
b3RlOiBwcmV2aW91cyBkZWZpbml0aW9uIG9mICd0cmFjZV9zY2hlZF9zdGF0X3J1bnRpbWUnIHdp
dGggdHlwZSAndm9pZChzdHJ1Y3QgdGFza19zdHJ1Y3QgKiwgdTY0KScge2FrYSAndm9pZChzdHJ1
Y3QgdGFza19zdHJ1Y3QgKiwgbG9uZyBsb25nIHVuc2lnbmVkIGludCknfQ0KICAyNTYgfCAgICAg
ICAgIHN0YXRpYyBpbmxpbmUgdm9pZCB0cmFjZV8jI25hbWUocHJvdG8pICAgICAgICAgICAgICAg
ICAgICAgICAgICBcDQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fg0K
Li9pbmNsdWRlL2xpbnV4L3RyYWNlcG9pbnQuaDo0MzA6OTogbm90ZTogaW4gZXhwYW5zaW9uIG9m
IG1hY3JvICdfX0RFQ0xBUkVfVFJBQ0UnDQogIDQzMCB8ICAgICAgICAgX19ERUNMQVJFX1RSQUNF
KG5hbWUsIFBBUkFNUyhwcm90byksIFBBUkFNUyhhcmdzKSwgICAgICAgICAgICAgIFwNCiAgICAg
IHwgICAgICAgICBefn5+fn5+fn5+fn5+fn4NCi4vaW5jbHVkZS9saW51eC90cmFjZXBvaW50Lmg6
NTUzOjk6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnREVDTEFSRV9UUkFDRScNCiAgNTUz
IHwgICAgICAgICBERUNMQVJFX1RSQUNFKG5hbWUsIFBBUkFNUyhwcm90byksIFBBUkFNUyhhcmdz
KSkNCiAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+DQouL2luY2x1ZGUvdHJhY2UvZXZlbnRz
L3NjaGVkLmg6NTE3OjE6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyAnREVGSU5FX0VWRU5U
Jw0KICA1MTcgfCBERUZJTkVfRVZFTlQoc2NoZWRfc3RhdF9ydW50aW1lLCBzY2hlZF9zdGF0X3J1
bnRpbWUsDQogICAgICB8IF5+fn5+fn5+fn5+fg0KbWFrZVszXTogKioqIFtzY3JpcHRzL01ha2Vm
aWxlLmJ1aWxkOjI5NjogL2hvbWUvdG1wL2x0dG5nLW1vZHVsZXMtMi4xMy4xMy9zcmMvcHJvYmVz
L2x0dG5nLXByb2JlLXNjaGVkLm9dIEVycm9yIDENCm1ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDo1ODQ6IC9ob21lL3RtcC9sdHRuZy1tb2R1bGVzLTIuMTMuMTMvc3JjL3Byb2Jl
c10gRXJyb3IgMg0KbWFrZVsxXTogKioqIFtNYWtlZmlsZToxOTQyOiAvaG9tZS90bXAvbHR0bmct
bW9kdWxlcy0yLjEzLjEzL3NyY10gRXJyb3IgMg0KbWFrZVsxXTogTGVhdmluZyBkaXJlY3Rvcnkg
Jy91c3Ivc3JjL2tlcm5lbHMvNS4xNC4wLTQ1Mi5lbDkueDg2XzY0Jw0KbWFrZTogKioqIFtNYWtl
ZmlsZTozMTogbW9kdWxlc10gRXJyb3IgMg0K
------=_Part_75839321_2114178019.1718811716718
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_75839321_2114178019.1718811716718--
