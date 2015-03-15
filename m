From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: how to generate CTF metadata
Date: Sun, 15 Mar 2015 18:34:44 -0400
Message-ID: <CAB4xu_0OtxF=zFBKP2JPHnkBsSVEnAQpUkkPiQ27944ETLwM3Q__48855.8136079975$1426458971$gmane$org@mail.gmail.com>
References: <5505F8D7.7060509@seznam.cz>
 <CAB4xu_3e6C-1ELJH-M-otbpqXzh9QeN_=8-t0guzLSiA9F8DNw@mail.gmail.com>
 <55060450.1060403@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f53.google.com ([209.85.215.53])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1YXH7w-0002Q2-CO
 for lttng-dev@lists.lttng.org; Sun, 15 Mar 2015 18:35:23 -0400
Received: by lagg8 with SMTP id g8so26054556lag.1
 for <lttng-dev@lists.lttng.org>; Sun, 15 Mar 2015 15:35:14 -0700 (PDT)
In-Reply-To: <55060450.1060403@seznam.cz>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dominik Taborsky <bremby@seznam.cz>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sun, Mar 15, 2015 at 6:14 PM, Dominik Taborsky <bremby@seznam.cz> wrote:
>
>
> On 03/15/2015 10:31 PM, Philippe Proulx wrote:
>>
>> On Sun, Mar 15, 2015 at 5:25 PM, Dominik Taborsky <bremby@seznam.cz>
>> wrote:
>>>
>>> Hello,
>>>
>>> I am working on a project that involves generating CTF metadata, but I am
>>> unsure about how to proceed. I am not sure about how to get information
>>> about types,
>>
>>
>> What "types" are you talking about exactly? What are you intending to
>> write to binary streams?
>
>
> Oh, sorry for not specifying exactly: I mean any defined, non-standard
> types. For example, when you do:
>
> typedef uint32_t key_t;
> typedef struct {
>         size_t len;
>         char *data;
> } wire_data_t;
>
> You use these types by their typedef'd name. Suppose then, you want to trace
> a function like:
>
> int do_work(key_t k, wire_data_t data);
>
> Then how do you know what those types are without looking at the typedefs?
> The runtime tracer does not have access to those header files. And even if
> it did, there may be tons of layers of typedefs. You've got to do this at
> runtime, which obviously leaves me with DWARF. Otherwise I'd have to specify
> the type info myself before or after the trace.
>
> So my main question is: how does the LTTng linux kernel module understand
> all the types so it may describe them in the CTF metadata?

LTTng-modules knows each field of event payload structures. They are described,
with a name and a basic C type, in instrumentation headers (see [1]). So
LTTng-modules does not have this unknown typedef constraint. The actual TSDL
metadata is produced in lttng-events.c; see [2] for an example of how a basic
C type is "converted" to a TSDL integer: __alignof__(x) is used for alignment,
(sizeof(x) * CHAR_BIT) for the size in bits, and this clever macro:

    #define lttng_is_signed_type(type) (((type)(-1)) < 0)

to know if the type is signed or not.

[1] http://git.lttng.org/?p=lttng-modules.git;a=blob;f=instrumentation/events/lttng-module/sched.h;h=1bea326135a428e0db10c42388a9683d58edd745;hb=HEAD#l231
[2] http://git.lttng.org/?p=lttng-modules.git;a=blob;f=lttng-events.h;h=118ea3b0db52d82e6072e17aa901c1850e22e43c;hb=HEAD#l74

Phil
>
>
> Dominik
>
>
>>
>> Phil
>>
>>> i.e. their size, signedness, alignment and possibly other. I
>>> know this information can be gathered from DWARF. Is that the primary way
>>> to
>>> do this? Is there any other, reasonable way? Can you point me at some
>>> code
>>> that does this? How does the LTTng linux kernel module work?
>>>
>>> Thanks.
>>>
>>> Dominik
>>>
>>> _______________________________________________
>>> lttng-dev mailing list
>>> lttng-dev@lists.lttng.org
>>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
