From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: [RFC PATCH lttng-modules v2 01/30] Bump minimum
 kernel version to 3.0
Date: Thu, 8 Nov 2018 16:59:36 -0500
Message-ID: <9f28b4a4-2561-c158-198d-c25bd30c4335__23562.7958005809$1541714263$gmane$org@efficios.com>
References: <20181108214535.12081-1-mjeanson@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 42rcdR4NLQzqbD
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:59:38 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 8E0F224B9AB
 for <lttng-dev@lists.lttng.org>; Thu,  8 Nov 2018 16:59:37 -0500 (EST)
In-Reply-To: <20181108214535.12081-1-mjeanson@efficios.com>
Content-Language: en-US
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

On 2018-11-08 4:45 p.m., Michael Jeanson wrote:
> Upstream Linux 3.0 was released 7 years ago, the oldest longterm release
> still supported is 3.16. On the distro kernels side, we still cover :
> 
>  RHEL / CentOS 7 and up
>  SLES11 SP2 and up
>  SLES12 and up
>  Ubuntu 12.04 (Precise) and up
>  Debian 7 (Wheezy) and up
>  Fedora 16 and up
> 
> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>

This patchset was compile tested on :

16:42:48 #538 (v4.7.10) completed with status SUCCESS
16:42:48 #543 (v4.1.52) completed with status SUCCESS
16:42:48 #531 (v4.14.79) completed with status SUCCESS
16:42:48 #533 (v4.12.14) completed with status SUCCESS
16:42:48 #537 (v4.8.17) completed with status SUCCESS
16:42:48 #528 (v4.17.19) completed with status SUCCESS
16:42:48 #535 (v4.10.17) completed with status SUCCESS
16:42:48 #539 (v4.6.7) completed with status SUCCESS
16:42:48 #544 (v4.2.8) completed with status SUCCESS
16:42:48 #534 (v4.11.12) completed with status SUCCESS
16:42:48 #525 (v4.20-rc1) completed with status SUCCESS
16:42:48 #526 (v4.19.1) completed with status SUCCESS
16:42:48 #542 (v4.3.6) completed with status SUCCESS
16:42:48 #532 (v4.13.16) completed with status SUCCESS
16:42:48 #545 (v4.0.9) completed with status SUCCESS
16:42:48 #546 (v3.19.8) completed with status SUCCESS
16:42:48 #540 (v4.5.7) completed with status SUCCESS
16:42:48 #536 (v4.9.135) completed with status SUCCESS
16:42:48 #541 (v4.4.162) completed with status SUCCESS
16:42:48 #530 (v4.15.18) completed with status SUCCESS
16:42:48 #529 (v4.16.18) completed with status SUCCESS
16:42:48 #550 (v3.15.10) completed with status SUCCESS
16:42:48 #527 (v4.18.17) completed with status SUCCESS
16:42:48 #551 (v3.14.79) completed with status SUCCESS
16:42:48 #552 (v3.13.11) completed with status SUCCESS
16:42:48 #547 (v3.18.124) completed with status SUCCESS
16:42:48 #548 (v3.17.8) completed with status SUCCESS
16:42:48 #549 (v3.16.60) completed with status SUCCESS
16:42:48 #553 (v3.12.74) completed with status SUCCESS
16:42:48 #555 (v3.10.108) completed with status SUCCESS
16:42:48 #554 (v3.11.10) completed with status SUCCESS
16:42:48 #556 (v3.9.11) completed with status SUCCESS
16:42:48 #560 (v3.5.7) completed with status SUCCESS
16:42:48 #559 (v3.6.11) completed with status SUCCESS
16:42:48 #563 (v3.2.102) completed with status SUCCESS
16:42:48 #557 (v3.8.13) completed with status SUCCESS
16:42:48 #558 (v3.7.10) completed with status SUCCESS
16:42:48 #561 (v3.4.113) completed with status SUCCESS
16:42:48 #564 (v3.1.10) completed with status SUCCESS
16:42:48 #562 (v3.3.8) completed with status SUCCESS
16:42:48 #565 (v3.0.101) completed with status SUCCESS
