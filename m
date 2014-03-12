From: Dimitri John Ledkov <xnox@ubuntu.com>
Subject: Re: Support for new arch 'ppc64le'
Date: Wed, 12 Mar 2014 11:26:12 +0000
Message-ID: <CANBHLUhP-FUrKP8nfiZe19JdihSyxuF9wEhzb53aCZYYg9hTvQ__45254.4024833061$1394623622$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=089e01183daaaa9fba04f4671a55
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ve0-f179.google.com ([209.85.128.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dimitri.ledkov@surgut.co.uk>) id 1WNhIg-0006kF-GX
	for lttng-dev@lists.lttng.org; Wed, 12 Mar 2014 07:26:22 -0400
Received: by mail-ve0-f179.google.com with SMTP id db12so9880750veb.38
	for <lttng-dev@lists.lttng.org>; Wed, 12 Mar 2014 04:26:13 -0700 (PDT)
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

--089e01183daaaa9fba04f4671a55
Content-Type: text/plain; charset=UTF-8

(sorry for breaking threading, I was not previously subscribed)

On 03/12/2014 12:58 AM, Mathieu Desnoyers wrote:
> I see that the patch you propose adds both "powerpc64le" and "aarch64" entries. Why are there two of them?

Currently there are two fairly recent architectures, which at the
moment can only be compiled with "gcc atomics" code path.
The two new architectures are (GNU Types):
* aarch64-linux-gnu (aka ARMv8, ARM64, AARCH64, etc)
* powerpc64le-linux-gnu

Upstream config.guess/config.sub/libtool/kernel/compilers have support
for these targets and many distributions are bootstrapping/building
archives for these architectures. Although for complete support,
ideally one would create tarballs on systems with patched libtool,
it's not required for distributions since we have support to update
config.guess/config.sub/libtool at package build time.

Thus I'd like to only request for aarch64/powerpc64el to be recognized
as archtypes that use gcc atomics in configure.ac. See attached patch.

Alternatively, you might want to consider making "gcc" atomics the
fallback ARCHTYPE, instead of "unknown" such that compilation of this
package is at least attempted on unexpected architectures.

-- 
Regards,

Dimitri.

--089e01183daaaa9fba04f4671a55
Content-Type: text/x-patch; charset=US-ASCII; name="arm64-ppc64el-archtypes.patch"
Content-Disposition: attachment; filename="arm64-ppc64el-archtypes.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hsoikq5b0

RGVzY3JpcHRpb246IFVzZSBnY2MgYXRvbWljcyBvbiBhYXJjaDY0L3Bvd2VycGM2NGxlIGZvciBi
b290c3RyYXBwaW5nLgpBdXRob3I6IERpbWl0cmkgSm9obiBMZWRrb3YgPHhub3hAdWJ1bnR1LmNv
bT4KCkluZGV4OiBiL2NvbmZpZ3VyZS5hYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBhL2NvbmZpZ3VyZS5hYwky
MDEzLTA2LTE5IDAxOjA4OjQxLjAwMDAwMDAwMCArMDAwMAorKysgYi9jb25maWd1cmUuYWMJMjAx
My0xMi0yMiAxMToxNzoyOC44MjEyODg5OTkgKzAwMDAKQEAgLTY5LDYgKzY5LDcgQEAKIAlbcG93
ZXJwY10sIFtBUkNIVFlQRT0icHBjIl0sCiAJW3BwYzY0XSwgW0FSQ0hUWVBFPSJwcGMiXSwKIAlb
cG93ZXJwYzY0XSwgW0FSQ0hUWVBFPSJwcGMiXSwKKwlbcG93ZXJwYzY0bGVdLCBbQVJDSFRZUEU9
ImdjYyJdLAogCVtwcGNdLCBbQVJDSFRZUEU9InBwYyJdLAogCVtzMzkwXSwgW0FSQ0hUWVBFPSJz
MzkwIl0sCiAJW3MzOTB4XSwgW0FSQ0hUWVBFPSJzMzkwIl0sCkBAIC03OCw2ICs3OSw3IEBACiAJ
W2lhNjRdLCBbQVJDSFRZUEU9ImdjYyJdLAogCVthcm0qXSwgW0FSQ0hUWVBFPSJhcm0iXSwKIAlb
bWlwcypdLCBbQVJDSFRZUEU9Im1pcHMiXSwKKwlbYWFyY2g2NF0sIFtBUkNIVFlQRT0iZ2NjIl0s
CiAJW0FSQ0hUWVBFPSJ1bmtub3duIl0KICkKIAo=
--089e01183daaaa9fba04f4671a55
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--089e01183daaaa9fba04f4671a55--
