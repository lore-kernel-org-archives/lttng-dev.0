From: Antoine Busque <abusque@efficios.com>
Subject: Re: [PATCH lttng-ust 2/2] Doc: add
 LTTNG_UST_CLOCK_PLUGIN to man page
Date: Thu, 23 Jul 2015 15:37:42 -0400
Message-ID: <CA+MZcXtt-hz1WyToHFe49W6iTUjuvRgm_VOn4w=MbMOxfeGarQ__19643.591452814$1437680314$gmane$org@mail.gmail.com>
References: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
 <1437674396-13934-2-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZIMJT-0006JL-2X
 for lttng-dev@lists.lttng.org; Thu, 23 Jul 2015 15:37:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 70132340436
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 19:37:47 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id w8MtjFcOBf1f for <lttng-dev@lists.lttng.org>;
 Thu, 23 Jul 2015 19:37:46 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 37D09340438
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 19:37:46 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id zwoyJ5YvXbDx for <lttng-dev@lists.lttng.org>;
 Thu, 23 Jul 2015 19:37:46 +0000 (UTC)
Received: from mail-ig0-f174.google.com (mail-ig0-f174.google.com
 [209.85.213.174])
 by mail.efficios.com (Postfix) with ESMTPSA id B91FC340430
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 19:37:45 +0000 (UTC)
Received: by igbpg9 with SMTP id pg9so1815099igb.0
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 12:37:42 -0700 (PDT)
In-Reply-To: <1437674396-13934-2-git-send-email-jonathan.rajotte-julien@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Jonathan Rajotte <jonathan.rajotte-julien@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Jul 23, 2015 at 1:59 PM, Jonathan Rajotte
<jonathan.rajotte-julien@efficios.com> wrote:
> +When using LTTng-tools keep in mind that lttng-sessiond uses lttng-ust clock

Maybe change to "uses lttng-ust's"

> +definition and functions. Thus LTTNG_UST_CLOCK_PLUGIN need to be define when

"needs to be defined"

> +.IP "LTTNG_UST_CLOCK_PLUGIN"
> +Used by the clock override plugin system. The environment variable is used to
> +provide the path of the shared object who will act as the clock override
> +plugin. Example can be found under doc/example/clock-override .

As per comments on previous patch, "path to", "which will", "An example" or
"Examples" and "doc/examples/" in the path.

Regards,
Antoine Busque.
