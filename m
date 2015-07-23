From: Antoine Busque <abusque@efficios.com>
Subject: Re: [PATCH lttng-ust 1/2] Doc: add
 LTTNG_UST_GETCPU_PLUGIN to man page
Date: Thu, 23 Jul 2015 15:32:35 -0400
Message-ID: <CA+MZcXvCqD3ZFw2+2jA+Ev+VHTd1JmgXT8U1x6mQKSPrOaZ6NA__49188.2125534632$1437680040$gmane$org@mail.gmail.com>
References: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <abusque@efficios.com>) id 1ZIMEV-0006GB-Ua
 for lttng-dev@lists.lttng.org; Thu, 23 Jul 2015 15:32:48 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 4D6D7340428
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 19:32:40 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id tEQ8yH2TSgUJ for <lttng-dev@lists.lttng.org>;
 Thu, 23 Jul 2015 19:32:39 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 8BB9F340431
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 19:32:39 +0000 (UTC)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (evm-mail-1.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id h9FOEAt6gBc1 for <lttng-dev@lists.lttng.org>;
 Thu, 23 Jul 2015 19:32:39 +0000 (UTC)
Received: from mail-ob0-f177.google.com (mail-ob0-f177.google.com
 [209.85.214.177])
 by mail.efficios.com (Postfix) with ESMTPSA id 19D37340428
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 19:32:39 +0000 (UTC)
Received: by obre1 with SMTP id e1so3025704obr.1
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2015 12:32:35 -0700 (PDT)
In-Reply-To: <1437674396-13934-1-git-send-email-jonathan.rajotte-julien@efficios.com>
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
> +provide the path of the shared object who will act as the getcpu override

 I'd phrase this as "provide the path to", and "which will act".

> +plugin. Example can be found under doc/example/getcpu-override .

"Examples" or "An Example", also the path should be
"doc/examples/getcpu-override".

Regards,
Antoine Busque
