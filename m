From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: [PATCH] use AC_CHECK_TOOL for objcopy and strip
Date: Mon, 14 Dec 2015 11:55:20 -0500
Message-ID: <566EF478.5000403__11756.3480198898$1450112196$gmane$org@efficios.com>
References: <1449852204-11379-1-git-send-email-nathan_lynch@mentor.com>
 <566AFDB5.8000103@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Jonathan.rajotte-julien@efficios.com>)
 id 1a8WPJ-0006WC-TH
 for lttng-dev@lists.lttng.org; Mon, 14 Dec 2015 11:55:33 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id C21AF340483
 for <lttng-dev@lists.lttng.org>; Mon, 14 Dec 2015 16:55:25 +0000 (UTC)
In-Reply-To: <566AFDB5.8000103@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org, Michael Jeanson <mjeanson@efficios.com>
List-Id: lttng-dev@lists.lttng.org

Hi Nathan,

Michael Jeanson already posted a patch [1] regarding this. His patch 
seems more complete since it also reuse objcopy for stripping instead of 
strip.

Could you test the patch?

Cheers

[1] https://lists.lttng.org/pipermail/lttng-dev/2015-December/025332.html

On 2015-12-11 11:45 AM, Nathan Lynch wrote:
> On 12/11/2015 10:43 AM, Nathan Lynch wrote:
>> The build steps for some tests refer directly to objcopy and strip,
>> which when cross-compiling can result in:
>>
>>   objcopy --only-keep-debug prog prog.debug
>>   objcopy: Unable to recognise the format of the input file `prog'
>>
>> Use AC_CHECK_TOOL to use appropriate programs for the target.
> (This patch is for lttng-tools.)
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Jonathan R. Julien
Efficios
