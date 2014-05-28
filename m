From: Gerlando Falauto <gerlando.falauto@keymile.com>
Subject: Re: Problem with UST related to dlload
Date: Wed, 28 May 2014 16:30:11 +0200
Message-ID: <5385F2F3.1090003__32098.3044723564$1401287484$gmane$org@keymile.com>
References: <CACsXv7BQ-T+6ggdM9+YPcu+hdy0Gxu6c_jxNj97AvzmDgXQ8Wg@mail.gmail.com>	<CACsXv7Au4yLptJnS5OayD8bqsgbi660bLbJobpczTnnWZbgx=g@mail.gmail.com>	<53847D18.3060203@keymile.com>	<5384A1F4.6080108@mentor.com>	<5384A409.4090107@keymile.com>	<5384A801.8040900@mentor.com>	<5384B787.8070009@keymile.com>
 <CACsXv7DV1OCXc9SV9SZp81B2uXoC-iBoH+VfwT6VpoXWc0+Wng@mail.gmail.com>
 <5385BCA9.5040207@mentor.com> <5385DEEA.50603@keymile.com>
 <5385EF5D.5040008@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-de.keymile.com ([195.8.104.250])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <prvs=02251e696b=gerlando.falauto@keymile.com>)
 id 1Wperz-0001xy-TV
 for lttng-dev@lists.lttng.org; Wed, 28 May 2014 10:30:25 -0400
In-Reply-To: <5385EF5D.5040008@mentor.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Woegerer, Paul" <Paul_Woegerer@mentor.com>, =?UTF-8?B?TWFydGluIMOcbnM=?= =?UTF-8?B?YWw=?= <martinunsal@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Thibault,
 Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Paul,

On 05/28/2014 04:14 PM, Woegerer, Paul wrote:
> On 05/28/2014 03:04 PM, Gerlando Falauto wrote:
>> So the hidden symbols are *NOT* weak at all (at least with my buggy
>> compiler). They are just automagically defined by the linker.
>
> I wrote "weak, in the sense that it can be linked without providing a
> definition somewhere".
> See: http://en.wikipedia.org/wiki/Weak_symbol "... When linking a binary
> executable, a weakly declared symbol does not need a definition. ...."

I agree with you. My initial understanding of weak symbol was probably 
wrong. I was not aware of the optional definition part, where in case of 
a missing definition the symbol assumes a value of all-zeroes.
But that was clear to me already when I wrote my previous mail.

Still, I don't get your point.
In our context, what would be the point of having those symbols as weak?
This would mean we could have zero, one or more definitions for it.
Don't we instead want exactly _one_ definition (per shared object), the 
one PROVIDEd by the linker when emitting the output file?

>> As a matter of fact, I don't think they should have ever been weak in
>> the first place. We *WANT* those symbols to exist and be well-defined,
>> and we should make sure the linker complies with this requirement, as
>> this is crucial to the correct behaviour of lttng-ust.
>> If we generate an inconsistency like the above and keep the weak
>> attribute, we would end up with code which compiles perfectly but
>> still will not work!
>>
>> BTW, the only reference I could find to how and why ldd defines those
>> symbols for section __start__/__stop__ is [1], which admittedly
>> states:  "I couldn't find any formal documentation for this feature,
>> only a few obscure mailing list references". :-(
>
> https://sourceware.org/binutils/docs-2.24/ld/Orphan-Sections.html#Orphan-Sections
>
> "If an orphaned section's name is representable as a C identifier then
> the linker will automatically see PROVIDE
> <https://sourceware.org/binutils/docs-2.24/ld/PROVIDE.html#PROVIDE> two
> symbols: __start_SECNAME and __stop_SECNAME, where SECNAME is the name
> of the section. These indicate the start address and end address of the
> orphaned section respectively."

Wonderful, thanks for sharing this! [Actually, yes, linker's ld, not ldd 
-- my mistake!]

Thanks again!
Gerlando

>
> --
> Best,
> Paul
>
