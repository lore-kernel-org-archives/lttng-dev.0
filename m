From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH lttng-modules] Fix: Building the event list
 fails on fragmented memory
Date: Tue, 23 Jun 2015 19:46:55 +0000 (UTC)
Message-ID: <1503217107.1784.1435088815111.JavaMail.zimbra__48209.4296058223$1435088921$gmane$org@efficios.com>
References: <55755E0D.7010902@leisener.de>
 <1905517223.241.1433920494952.JavaMail.zimbra@efficios.com>
 <557838F1.9020808@leisener.de>
 <1586680029.1815.1434223948187.JavaMail.zimbra@efficios.com>
 <20150623134638.GA3944@hal>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="----=_Part_1782_462196168.1435088815109"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Z7UA3-0007YR-Kn
 for lttng-dev@lists.lttng.org; Tue, 23 Jun 2015 15:47:21 -0400
In-Reply-To: <20150623134638.GA3944@hal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jan Glauber <jan.glauber@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

------=_Part_1782_462196168.1435088815109
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

----- On Jun 23, 2015, at 9:46 AM, Jan Glauber jan.glauber@gmail.com wrote:

> On Sat, Jun 13, 2015 at 07:32:28PM +0000, Mathieu Desnoyers wrote:
>> ----- On Jun 10, 2015, at 9:17 AM, Martin Leisener martin@leisener.de wr=
ote:
>>=20
>> > Hi Mathieu,
>> >=20
>> > sorry for sending the broken patch, I fell for some "smart" formating =
of my
>> > email client, I cannot utilize it myself the way I send it.
>> > Hence I now send the patch again as it was original intended. Sent to =
myself, I
>> > can apply it, so I hope it now works in general as well
>> > I examined as recommended diff -urN, it seems the output can be utiliz=
ed by
>> > patch the same way as git diff.
>> > Hope it is now received the way I intended.
>>=20
>> Hi Martin,
>>=20
>> I tried you patch on a x86-64 machine (my laptop), and although taking a
>> single kernel trace worked fine, it appears to OOPS when I run
>>=20
>> (in lttng-tools)
>> cd tests
>> ./run.sh root_regression
>=20
> Hi Mathieu,
>=20
> can you please share the oops message so I can have a look?

Sure,

Here is the backtrace happening with the attached patch over lttng-modules
commit 8c6e7f13c778701dec2d6549f1e2ca98970907a0. I modified your patch
slightly.

[ 4078.314978] BUG: unable to handle kernel paging request at ffffc900038d9=
95e
[ 4078.315824] IP: [<ffffffff81316f12>] __memcpy+0x12/0x20
[ 4078.315824] PGD 236c92067 PUD 236c93067 PMD bac0c067 PTE 0
[ 4078.315824] Oops: 0000 [#1] SMP=20
[ 4078.315824] Modules linked in: lttng_probe_workqueue(O) lttng_probe_vmsc=
an(O) lttng_probe_udp(O) lttng_probe_timer(O) lttng_probe_sunrpc(O) lttng_p=
robe_statedump(O) lttng_probe_sock(O) lttng_probe_skb(O) lttng_probe_signal=
(O) lttng_probe_scsi(O) lttng_probe_sched(O) lttng_probe_regmap(O) lttng_pr=
obe_rcu(O) lttng_probe_random(O) lttng_probe_printk(O) lttng_probe_power(O)=
 lttng_probe_net(O) lttng_probe_napi(O) lttng_probe_module(O) lttng_probe_k=
mem(O) lttng_probe_jbd2(O) lttng_probe_irq(O) lttng_probe_ext4(O) lttng_pro=
be_compaction(O) lttng_probe_block(O) lttng_types(O) lttng_ring_buffer_meta=
data_mmap_client(O) lttng_ring_buffer_client_mmap_overwrite(O) lttng_ring_b=
uffer_client_mmap_discard(O) lttng_ring_buffer_metadata_client(O) lttng_rin=
g_buffer_client_overwrite(O) lttng_ring_buffer_client_discard(O) lttng_trac=
er(O) lttng_statedump(O) lttng_kprobes(O) lttng_lib_ring_buffer(O) lttng_kr=
etprobes(O) virtio_blk virtio_net virtio_pci virtio_ring virtio
[ 4078.315824] CPU: 5 PID: 4258 Comm: lttng-consumerd Tainted: G           =
O    4.1.0 #7
[ 4078.315824] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
Bochs 01/01/2011
[ 4078.315824] task: ffff8802350c3660 ti: ffff8800bae84000 task.ti: ffff880=
0bae84000
[ 4078.315824] RIP: 0010:[<ffffffff81316f12>]  [<ffffffff81316f12>] __memcp=
y+0x12/0x20
[ 4078.315824] RSP: 0018:ffff8800bae87da0  EFLAGS: 00010246
[ 4078.315824] RAX: ffff880235439025 RBX: 0000000000000fd8 RCX: 00000000000=
001fb
[ 4078.315824] RDX: 0000000000000000 RSI: ffffc900038d995e RDI: ffff8802354=
39025
[ 4078.315824] RBP: ffff8800bae87db8 R08: ffff8800bacecc00 R09: 00000000000=
08000
[ 4078.315824] R10: 0000000000000000 R11: 0000000000000246 R12: ffff8800bae=
87dc8
[ 4078.315824] R13: ffff88023466e800 R14: 0000000000000fd8 R15: 00000000000=
00fd8
[ 4078.315824] FS:  00007f5d3b1cc700(0000) GS:ffff8802372a0000(0000) knlGS:=
0000000000000000
[ 4078.315824] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 4078.315824] CR2: ffffc900038d995e CR3: 00000000bb1ed000 CR4: 00000000000=
006e0
[ 4078.315824] Stack:
[ 4078.315824]  ffffffffa01ac797 ffff8800bb5bd480 ffff8800bb5bd4d0 ffff8800=
bae87e48
[ 4078.315824]  ffffffffa0073060 ffff88023466e800 0000000000000000 00000000=
00000fd8
[ 4078.315824]  ffffffff00000001 ffff8800bacecc00 0000000000000fd8 00000000=
00008025
[ 4078.315824] Call Trace:
[ 4078.315824]  [<ffffffffa01ac797>] ? lttng_event_write+0x87/0xb0 [lttng_r=
ing_buffer_metadata_client]
[ 4078.315824]  [<ffffffffa0073060>] lttng_metadata_output_channel+0xd0/0x1=
20 [lttng_tracer]
[ 4078.315824]  [<ffffffffa00755f9>] lttng_metadata_ring_buffer_ioctl+0x79/=
0xd0 [lttng_tracer]
[ 4078.315824]  [<ffffffff8117ba10>] do_vfs_ioctl+0x2e0/0x4e0
[ 4078.315824]  [<ffffffff812b35c7>] ? file_has_perm+0x87/0xa0
[ 4078.315824]  [<ffffffff8117bc91>] SyS_ioctl+0x81/0xa0
[ 4078.315824]  [<ffffffff810115d1>] ? syscall_trace_leave+0xd1/0xe0
[ 4078.315824]  [<ffffffff818bbd37>] tracesys_phase2+0x84/0x89
[ 4078.315824] Code: 5b 5d c3 66 0f 1f 44 00 00 e8 6b fc ff ff eb e1 90 90 =
90 90 90 90 90 90 90 0f 1f 44 00 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 =
<f3> 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 f3=20
[ 4078.315824] RIP  [<ffffffff81316f12>] __memcpy+0x12/0x20
[ 4078.315824]  RSP <ffff8800bae87da0>
[ 4078.315824] CR2: ffffc900038d995e
[ 4078.315824] ---[ end trace a05b652829ceda48 ]---
[ 4078.433848] LTTng: block device enumeration is not supported by kernel


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
------=_Part_1782_462196168.1435088815109
Content-Type: text/x-patch;
 name=0001-Fix-Building-the-event-list-fails-on-fragmented-memo.patch
Content-Disposition: attachment;
 filename=0001-Fix-Building-the-event-list-fails-on-fragmented-memo.patch
Content-Transfer-Encoding: base64

RnJvbSAyNDk1MTg1OWI1OGEwNmI4ODY3MTY1Y2U0ODU3MzQ2NTM1ZDNkYzczIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJ0aW4gTGVpc2VuZXIgPG1hcnRpbkBsZWlzZW5lci5kZT4K
RGF0ZTogV2VkLCAxMCBKdW4gMjAxNSAxNToxNzozNyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIEZp
eDogQnVpbGRpbmcgdGhlIGV2ZW50IGxpc3QgZmFpbHMgb24gZnJhZ21lbnRlZCBtZW1vcnkKCk9u
IGEgc21hbGwgYXJtIGlteDYgc29sbyB3aXRoIDI1Nk1CIFJBTSBpdCBvZnRlbiBoYXBwZW5zIHRo
YXQgbWVtb3J5CmJlY29tZXMgZnJhZ21lbnRlZCByYXRoZXIgcXVpY2tseSwgc28gdGhhdCBrbWFs
bG9jIHdpbGwgbm90IGJlIGFibGUgdG8KZ2V0IGVub3VnaCBjb25zZWN1dGl2ZSBwYWdlcyAoZW5v
Y3VudGVyZWQgZm9yIGV4YW1wbGUgaWYgeW91IGVuYWJsZSBhbGwKa2VybmVsIGV2ZW50czogbHR0
bmcgZW5hYmxlLWV2ZW50IC1rIHN5c2NhbGwgLS1hbGwpLgoKVGhpcyBwYXRjaCBzd2l0Y2hlcyB0
aGUgYWxsb2NhdGlvbiB0byB2bWFsbG9jLiBUZXN0ZWQgZm9yIHg4NiBvbiBVYnVudHUKMTIuMDQg
THRzIGFuZCBvbiBpbXg2IHNvbG8gMjU2TUIgUkFNCgpJZiB0aGlzIHBhdGNoIGlzIG5vdCBhcHBs
aWVkLCB5b3UgY2FuIGlkZW50aWZ5IGxvdyBhbmQvb3IgZnJhZ21lbnRlZAptZW1vcnkgZmFpbHVy
ZXMgYnkgbG9va2luZyBhdCB0aGUga2VybmVsIHJpbmcgYnVmZmVyIChwbGVhc2UgaWdub3JlIERN
QSwKaXQgaXMgZHVlIHRvIHNvbWUgbWVtb3J5IHNldHVwIG1pc2NvbmZpZ3VyYXRpb24sIHNob3Vs
ZCByZWFkIE5vcm1hbCk6CgouLi4KWyAgMzIxLjk5MzgyMF0gbHR0bmctc2Vzc2lvbmQ6IHBhZ2Ug
YWxsb2NhdGlvbiBmYWlsdXJlOiBvcmRlcjo0LCBtb2RlOjB4MTA0MGQwCi4uLgpbICAzMjEuOTk0
NzExXSBsb3dtZW1fcmVzZXJ2ZVtdOiAwIDAgMApbICAzMjEuOTk0NzI3XSBETUE6IDgwMSo0a0Ig
KFVFTUMpIDQyNCo4a0IgKEVNQykgMzU1KjE2a0IgKFVFTUMpIDM0NCozMmtCIChNQykgMzQwKjY0
a0IgKEMpIDgqMTI4a0IgKEMpIDAqMjU2a0IgMCo1MTJrQiAwKjEwMjRrQiAwKjIwNDhrQiAwKjQw
OTZrQiAwKjgxOTJrQiAwKjE2Mzg0a0IgMCozMjc2OGtCID0gNDYwNjhrQgoKWyBFZGl0IGJ5IE1h
dGhpZXU6IHVzZSB2emFsbG9jKCkgcmF0aGVyIHRoYW4gdm1hbGxvYygpICsgbWVtc2V0IDAuIF0K
ClNpZ25lZC1vZmYtYnk6IE1hcnRpbiBMZWlzZW5lciA8bWFydGluQGxlaXNlbmVyLmRlPgpTaWdu
ZWQtb2ZmLWJ5OiBNYXRoaWV1IERlc25veWVycyA8bWF0aGlldS5kZXNub3llcnNAZWZmaWNpb3Mu
Y29tPgotLS0KIGx0dG5nLWV2ZW50cy5jIHwgMTYgKysrKysrKysrKystLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbHR0
bmctZXZlbnRzLmMgYi9sdHRuZy1ldmVudHMuYwppbmRleCA3ZWVjMDRjLi45YjYzNzg5IDEwMDY0
NAotLS0gYS9sdHRuZy1ldmVudHMuYworKysgYi9sdHRuZy1ldmVudHMuYwpAQCAtMzksNiArMzks
NyBAQAogI2luY2x1ZGUgIndyYXBwZXIvZmlsZS5oIgogI2luY2x1ZGUgPGxpbnV4L2poYXNoLmg+
CiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5oPgorI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4K
IAogI2luY2x1ZGUgIndyYXBwZXIvdXVpZC5oIgogI2luY2x1ZGUgIndyYXBwZXIvdm1hbGxvYy5o
IgkvKiBmb3Igd3JhcHBlcl92bWFsbG9jX3N5bmNfYWxsKCkgKi8KQEAgLTEzMiw4ICsxMzMsNyBA
QCBzdHJ1Y3QgbHR0bmdfc2Vzc2lvbiAqbHR0bmdfc2Vzc2lvbl9jcmVhdGUodm9pZCkKIAkJCUdG
UF9LRVJORUwpOwogCWlmICghbWV0YWRhdGFfY2FjaGUpCiAJCWdvdG8gZXJyX2ZyZWVfc2Vzc2lv
bjsKLQltZXRhZGF0YV9jYWNoZS0+ZGF0YSA9IGt6YWxsb2MoTUVUQURBVEFfQ0FDSEVfREVGQVVM
VF9TSVpFLAotCQkJR0ZQX0tFUk5FTCk7CisJbWV0YWRhdGFfY2FjaGUtPmRhdGEgPSB2emFsbG9j
KE1FVEFEQVRBX0NBQ0hFX0RFRkFVTFRfU0laRSk7CiAJaWYgKCFtZXRhZGF0YV9jYWNoZS0+ZGF0
YSkKIAkJZ290byBlcnJfZnJlZV9jYWNoZTsKIAltZXRhZGF0YV9jYWNoZS0+Y2FjaGVfYWxsb2Mg
PSBNRVRBREFUQV9DQUNIRV9ERUZBVUxUX1NJWkU7CkBAIC0xNjIsNyArMTYyLDcgQEAgdm9pZCBt
ZXRhZGF0YV9jYWNoZV9kZXN0cm95KHN0cnVjdCBrcmVmICprcmVmKQogewogCXN0cnVjdCBsdHRu
Z19tZXRhZGF0YV9jYWNoZSAqY2FjaGUgPQogCQljb250YWluZXJfb2Yoa3JlZiwgc3RydWN0IGx0
dG5nX21ldGFkYXRhX2NhY2hlLCByZWZjb3VudCk7Ci0Ja2ZyZWUoY2FjaGUtPmRhdGEpOworCXZm
cmVlKGNhY2hlLT5kYXRhKTsKIAlrZnJlZShjYWNoZSk7CiB9CiAKQEAgLTE1MjMsMTAgKzE1MjMs
MTYgQEAgaW50IGx0dG5nX21ldGFkYXRhX3ByaW50ZihzdHJ1Y3QgbHR0bmdfc2Vzc2lvbiAqc2Vz
c2lvbiwKIAkJdG1wX2NhY2hlX2FsbG9jX3NpemUgPSBtYXhfdCh1bnNpZ25lZCBpbnQsCiAJCQkJ
c2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPmNhY2hlX2FsbG9jICsgbGVuLAogCQkJCXNlc3Npb24t
Pm1ldGFkYXRhX2NhY2hlLT5jYWNoZV9hbGxvYyA8PCAxKTsKLQkJdG1wX2NhY2hlX3JlYWxsb2Mg
PSBrcmVhbGxvYyhzZXNzaW9uLT5tZXRhZGF0YV9jYWNoZS0+ZGF0YSwKLQkJCQl0bXBfY2FjaGVf
YWxsb2Nfc2l6ZSwgR0ZQX0tFUk5FTCk7CisJCXRtcF9jYWNoZV9yZWFsbG9jID0gdnphbGxvYyh0
bXBfY2FjaGVfYWxsb2Nfc2l6ZSk7CiAJCWlmICghdG1wX2NhY2hlX3JlYWxsb2MpCiAJCQlnb3Rv
IGVycjsKKwkJaWYgKHNlc3Npb24tPm1ldGFkYXRhX2NhY2hlLT5kYXRhKSB7CisJCQltZW1jcHko
dG1wX2NhY2hlX3JlYWxsb2MsCisJCQkJc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPmRhdGEsCisJ
CQkJc2Vzc2lvbi0+bWV0YWRhdGFfY2FjaGUtPmNhY2hlX2FsbG9jKTsKKwkJCXZmcmVlKHNlc3Np
b24tPm1ldGFkYXRhX2NhY2hlLT5kYXRhKTsKKwkJfQorCiAJCXNlc3Npb24tPm1ldGFkYXRhX2Nh
Y2hlLT5jYWNoZV9hbGxvYyA9IHRtcF9jYWNoZV9hbGxvY19zaXplOwogCQlzZXNzaW9uLT5tZXRh
ZGF0YV9jYWNoZS0+ZGF0YSA9IHRtcF9jYWNoZV9yZWFsbG9jOwogCX0KLS0gCjEuOS4xCgo=
------=_Part_1782_462196168.1435088815109
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

------=_Part_1782_462196168.1435088815109--
