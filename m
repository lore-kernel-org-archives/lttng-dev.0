From: Michael Jeanson <mjeanson@efficios.com>
Subject: Re: liblttng-ust and lttng-tools fail to compile with
 -fno-common
Date: Thu, 16 Jan 2020 15:43:03 -0500
Message-ID: <edc3f81d-8e2f-9e9f-b34f-8bc9ea66498b@efficios.com>
References: <CADYdroNv4Ak_tkP-bpPz7+SBqoWqnwjkUi46ZjZq5YOpo_QU+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 by lists.lttng.org (Postfix) with ESMTPS id 47zGNm526hz1lJx
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jan 2020 15:43:04 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 09AA7245EE3
 for <lttng-dev@lists.lttng.org>; Thu, 16 Jan 2020 15:43:04 -0500 (EST)
In-Reply-To: <CADYdroNv4Ak_tkP-bpPz7+SBqoWqnwjkUi46ZjZq5YOpo_QU+g@mail.gmail.com>
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

On 2020-01-16 10:26 a.m., Norbert Lange wrote:
> Hello,
> 
> The flag -fno-common will cause multiple duplicate symbols, gcc 10
> will use this as default, so it will only be a matter of time till you
> get some more FTB reports ;)
> 
> Norbert

 Thanks for the heads-up, I've submitted these patches:

 https://review.lttng.org/c/lttng-ust/+/2809
 https://review.lttng.org/c/lttng-tools/+/2810

Cheers,

Michael
