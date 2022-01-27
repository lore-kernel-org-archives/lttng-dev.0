Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D37EC433F5
	for <lttng-dev@archiver.kernel.org>; Thu, 27 Jan 2022 20:37:36 +0000 (UTC)
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4JlC7z454QzQvY;
	Thu, 27 Jan 2022 15:37:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1643315856;
	bh=De0BpwRHDndKSTnWAzxg7xInbHyOit++kvF1P6bU0EM=;
	h=Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=DiqHPeyCy+b8HJK5K3qMVl/cm7+TtwViyG82JZS0vc2DYeQUq8qAhaNrFgOKl+FBr
	 YNb5o/nlpT/IuSDm3/Gx6ERUaxbExBydNKoVseitT50fcMYm3nU03dwJ+HfKHdknf8
	 iOTE9u68j39IKJVuzKzwNmSy94+angndkAxw+nwgSlaNrtBmHE23DCcKB47qi0vzHu
	 Q3glMp9K8NtR944KAu/3IXvwIYBJCBlxLlXRIMUuTI265aDGG1z9LayJAQMeDeFFcr
	 1MokW1tw0pJ+x2cvincRQ31ONQ9xz0iqz7eodI5ON/AXPAkkbXFFqqVPPdT0/2alZW
	 pjeQNfQBxDsdw==
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 4JlC7y2qJyzQPf
 for <lttng-dev@lists.lttng.org>; Thu, 27 Jan 2022 15:37:34 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id E096137871C
 for <lttng-dev@lists.lttng.org>; Thu, 27 Jan 2022 15:37:28 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id PTavphWkYKx1; Thu, 27 Jan 2022 15:37:28 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 5F5813787B2;
 Thu, 27 Jan 2022 15:37:28 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5F5813787B2
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id RNPLVCDXop1S; Thu, 27 Jan 2022 15:37:28 -0500 (EST)
Received: from Mercury (unknown [107.159.88.171])
 by mail.efficios.com (Postfix) with ESMTPSA id 3B88A37889C;
 Thu, 27 Jan 2022 15:37:28 -0500 (EST)
Date: Thu, 27 Jan 2022 15:37:28 -0500
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
Message-ID: <YfMCiCbVI/t2zBkX@Mercury>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [lttng-dev] [RELEASE] LTTng-tools 2.12.8 - (Ta) Meilleure
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.35
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: =?utf-8?q?J=C3=A9r=C3=A9mie_Galarneau_via_lttng-dev?=
 <lttng-dev@lists.lttng.org>
Reply-To: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
 <jeremie.galarneau@efficios.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

SGkgYWxsLAoKV2UgaGF2ZSBqdXN0IHJlbGVhc2VkIHRoZSBlaWdodGggYnVnLWZpeCByZWxlYXNl
IG9mIExUVG5nLXRvb2xzIDIuMTLigJQoVGEpCk1laWxsZXVyZS4gVGhpcyByZWxlYXNlIGFkZHJl
c3NlcyBhIG51bWJlciBvZiBpc3N1ZXMgbGlzdGVkIGJlbG93LgoKMjAyMi0wMS0yNiBsdHRuZy10
b29scyAyLjEyLjggKE5hdGlvbmFsIFBlYW51dCBCcml0dGxlIERheSkKICAgICogUmVsaWNlbmNl
IGFsbCBzb3VyY2UgYW5kIGhlYWRlciBmaWxlcyBpbmNsdWRlZCBpbiBMR1BMIGNvZGUKICAgICog
Rml4OiBzZXNzaW9uZDogdXNlIG9mIG51bGwgc2Vzc2lvbiB3aGVuIHNlc3Npb24gaXMgbm90IGZv
dW5kCiAgICAqIE1vdmUgdXRpbHNfZXhwYW5kX3BhdGggYW5kIHV0aWxzX2V4cGFuZF9wYXRoX2tl
ZXBfc3ltbGluayB0byBsaWJwYXRoLmxhCiAgICAqIExpbmsgbHR0bmcgZXhlY3V0YWJsZSBvbiBs
aWJjb21tb24tbGdwbC5hCiAgICAqIEludHJvZHVjZSBsaWJjb21tb24tbGdwbCBmb3IgbGlibHR0
bmctY3RsCiAgICAqIFJlbmFtZSBsaWJjb21tb24uc28gdG8gbGliY29tbW9uLWdwbC5zbwogICAg
KiBDb3B5cmlnaHQgb3duZXJzaGlwIHRyYW5zZmVyCiAgICAqIENvcHlyaWdodCBvd25lcnNoaXAg
dHJhbnNmZXIKICAgICogRml4OiByZWxheWQ6IGVycm9uZW91cyBydW5kaXIgcGVybWlzc2lvbiBs
b2dnaW5nIG1lc3NhZ2UKICAgICogRml4OiBzZXNzaW9uZDogcm90YXRpb24gdGhyZWFkOiBmYXRh
bCBlcnJvciB3aGVuIG5vdCBmaW5kaW5nIGEgc2Vzc2lvbgogICAgKiBGaXg6IHJlbGF5ZDogcm90
YXRpb24gZmFpbHVyZSBmb3IgbXVsdGktZG9tYWluIHNlc3Npb24KICAgICogRml4OiBsdHRuZy1j
dGw6IGx0dG5nX2xpc3Rfc2Vzc2lvbnM6IGluaXRpYWxpemUgb3V0X3Nlc3Npb25zIHRvIE5VTEwg
d2hlbiByZXR1cm5pbmcgMAogICAgKiBGaXg6IGx0dG5nOiBpbml0aWFsaXplIHZhcmlhYmxlIGlu
IHJ1bl9jb21tYW5kX3N0cmluZwogICAgKiBGaXg6IGNvbnN1bWVyLXN0cmVhbTogbGl2ZSB2aWV3
ZXJzIG9ic2VydmUgdGltZXN0YW1wcyBnb2luZyBiYWNrd2FyZHMKICAgICogRml4OiByZWxheWQ6
IHJlc3NvdXJjZSBsZWFrcyBvbiB2aWV3ZXJfc3RyZWFtX2NyZWF0ZSBlcnJvcgogICAgKiBGaXg6
IHJlbGF5ZDogbGl2ZTogZXJyb25lb3VzIG1lc3NhZ2UgdGltZXN0YW1wIG9ic2VydmVkIGZyb20g
bGl2ZSB2aWV3ZXIKICAgICogRml4OiByZWxheWQ6IGZhaWx1cmUgdG8gb3BlbiBjaHVuayBmaWxl
cyBjb25jdXJyZW50bHkgd2l0aCBzZXNzaW9uIGNsZWFyCiAgICAqIEZpeDogcmVsYXlkOiBsaXZl
OiBtZXRhZGF0YSBzdHJlYW0gcmVmZXJlbmNlIGNvdW50IDwgMCBhc3NlcnQKCkFzIGFsd2F5cywg
cGxlYXNlIHJlcG9ydCBhbnkgaXNzdWUgeW91IG1heSBlbmNvdW50ZXIgdG8gYnVncy5sdHRuZy5v
cmcKb3Igb24gdGhpcyBtYWlsaW5nIGxpc3QuCgpQcm9qZWN0IHdlYnNpdGU6IGh0dHBzOi8vbHR0
bmcub3JnCgpEb3dubG9hZCBsaW5rOgpodHRwczovL2x0dG5nLm9yZy9maWxlcy9sdHRuZy10b29s
cy9sdHRuZy10b29scy0yLjEyLjgudGFyLmJ6MgoKR1BHIHNpZ25hdHVyZToKaHR0cHM6Ly9sdHRu
Zy5vcmcvZmlsZXMvbHR0bmctdG9vbHMvbHR0bmctdG9vbHMtMi4xMi44LnRhci5iejIuYXNjCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmx0dG5nLWRldiBt
YWlsaW5nIGxpc3QKbHR0bmctZGV2QGxpc3RzLmx0dG5nLm9yZwpodHRwczovL2xpc3RzLmx0dG5n
Lm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vbHR0bmctZGV2Cg==
