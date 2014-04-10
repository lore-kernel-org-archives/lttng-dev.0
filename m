From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-tools] utils: Rework
	utils_parse_size_suffix
Date: Thu, 10 Apr 2014 16:14:56 -0400
Message-ID: <CAFXXi0=K1e-ZuFVDGRJXQjHHGLmosSi40oyLxWJNJnPL2xCRaA__27779.1979759515$1397160991$gmane$org@mail.gmail.com>
References: <1397143819-4563-1-git-send-email-simon.marchi@polymtl.ca>
 <20140410195751.GE28773@dalia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1WYLNk-0003no-2t
 for lttng-dev@lists.lttng.org; Thu, 10 Apr 2014 16:15:37 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so4456308iec.21
 for <lttng-dev@lists.lttng.org>; Thu, 10 Apr 2014 13:15:26 -0700 (PDT)
In-Reply-To: <20140410195751.GE28773@dalia>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 10 April 2014 15:57, David Goulet <dgoulet@efficios.com> wrote:
> On 10 Apr (11:30:19), Simon Marchi wrote:
>> Ok, so there are a lot of problems with this function (sorry :|). Taking
>> the regex road is probably to complicated for nothing, so here is a
>> version without regexes.
>>
>> I added many test cases as suggested by Sandeep Chaudhary and Daniel
>> Thibault. I tested on both Intel 32 and 64 bits.
>>
>> Would fix #633
>
> Why are you not sure of that? :P

Would fix if merged :P

> Can you explain *why* regex was a bad choice here (if the 633 ticket
> does not already explain it).

I did not say it was a *bad* choice, but when I look at the old and
new function, the new one seems less cryptic (without the matches and
all). This is debatable.

> Thanks!
> David
