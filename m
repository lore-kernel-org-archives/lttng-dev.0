From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: Re: Problem with UST related to dlload
Date: Wed, 28 May 2014 17:05:58 +0200
Message-ID: <5385FB56.2040909__35511.7550855086$1401289637$gmane$org@mentor.com>
References: <CACsXv7BQ-T+6ggdM9+YPcu+hdy0Gxu6c_jxNj97AvzmDgXQ8Wg@mail.gmail.com>	<CACsXv7Au4yLptJnS5OayD8bqsgbi660bLbJobpczTnnWZbgx=g@mail.gmail.com>	<53847D18.3060203@keymile.com>	<5384A1F4.6080108@mentor.com>	<5384A409.4090107@keymile.com>	<5384A801.8040900@mentor.com>	<5384B787.8070009@keymile.com>
 <CACsXv7DV1OCXc9SV9SZp81B2uXoC-iBoH+VfwT6VpoXWc0+Wng@mail.gmail.com>
 <5385BCA9.5040207@mentor.com> <5385DEEA.50603@keymile.com>
 <5385EF5D.5040008@mentor.com> <5385F2F3.1090003@keymile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <Paul_Woegerer@mentor.com>) id 1WpfQe-0002GL-Hu
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 11:06:14 -0400
In-Reply-To: <5385F2F3.1090003@keymile.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Gerlando Falauto <gerlando.falauto@keymile.com>, =?UTF-8?B?TWFydGluIMOc?= =?UTF-8?B?bnNhbA==?= <martinunsal@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
 Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

On 05/28/2014 04:30 PM, Gerlando Falauto wrote:
> Hi Paul,
>
> On 05/28/2014 04:14 PM, Woegerer, Paul wrote:
>> On 05/28/2014 03:04 PM, Gerlando Falauto wrote:
>>> So the hidden symbols are *NOT* weak at all (at least with my buggy
>>> compiler). They are just automagically defined by the linker.
>>
>> I wrote "weak, in the sense that it can be linked without providing a
>> definition somewhere".
>> See: http://en.wikipedia.org/wiki/Weak_symbol "... When linking a binary
>> executable, a weakly declared symbol does not need a definition. ...."
>
> I agree with you. My initial understanding of weak symbol was probably
> wrong. I was not aware of the optional definition part, where in case
> of a missing definition the symbol assumes a value of all-zeroes.
> But that was clear to me already when I wrote my previous mail.
>
> Still, I don't get your point.
> In our context, what would be the point of having those symbols as weak?

There is no point. That's why I previously admitted:

> It tried your approach of removing __attribute__((weak)) and to my
> surprise this really seems to be sufficient. 

So I do think weak should be removed. We are in alignment here.

--
Paul
