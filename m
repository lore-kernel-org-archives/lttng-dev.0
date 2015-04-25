From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [BUG] lttng-sessiond
Date: Sat, 25 Apr 2015 15:37:25 +0000 (UTC)
Message-ID: <196643977.36058.1429976245491.JavaMail.zimbra__12652.4064610296$1429976305$gmane$org@efficios.com>
References: <3E06425C-5C41-4BF7-8156-A62C4E9B5E60@mailbox.tu-dresden.de>
 <1230298824.35208.1429817200877.JavaMail.zimbra@efficios.com>
 <1795330554.35257.1429820009277.JavaMail.zimbra@efficios.com>
 <DE838679-50E7-464E-B47B-934EF31813A9@mailbox.tu-dresden.de>
 <480136718.35882.1429900335415.JavaMail.zimbra@efficios.com>
 <9E6E6DE2-E219-4F79-9687-BE7A45910C34@mailbox.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ym291-0005nU-R1
 for lttng-dev@lists.lttng.org; Sat, 25 Apr 2015 11:37:28 -0400
In-Reply-To: <9E6E6DE2-E219-4F79-9687-BE7A45910C34@mailbox.tu-dresden.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Hannes Weisbach <hannes.weisbach@mailbox.tu-dresden.de>, philippe proulx <philippe.proulx@efficios.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

----- Original Message -----
> > 
> > Why do you need to load those explicitly ? They should be
> > already loaded by default. I don't get those errors here.
> > Which shell are you using (sh symlink) ? Can you reproduce
> > using bash ?
> Ok.  Found the bug.  In append_list_to_probes() index is used to get
> the current index into the probes array.  However in the loop, index
> is never incremented.  Therefore, the first entry of probes is
> overwritten, but nr_probes is incremented, and later those "empty"
> entries are referenced.
> 
> There is also a memory leak in append_list_to_probes():
>  
> tmp_list = strdup(list); // uses malloc()
> next = strtok(tmp_list, ","); // tmp_list needs to be NULL except in the
> first iteration
> tmp_list = NULL; // so set it NULL
> free(tmp_list); // good intention, does not work.

Thanks for spotting those issues! I'm CCing the
author of this code.

Mathieu

> 
> Best regards,
> Hannes
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
