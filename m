From: Dominik Taborsky <bremby@seznam.cz>
Subject: Re: how to generate CTF metadata
Date: Sun, 15 Mar 2015 23:14:40 +0100
Message-ID: <55060450.1060403__36683.4733555608$1426457815$gmane$org@seznam.cz>
References: <5505F8D7.7060509@seznam.cz>
 <CAB4xu_3e6C-1ELJH-M-otbpqXzh9QeN_=8-t0guzLSiA9F8DNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mxl1.seznam.cz ([77.75.72.44])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <bremby@seznam.cz>) id 1YXGpB-0002JE-TQ
 for lttng-dev@lists.lttng.org; Sun, 15 Mar 2015 18:16:02 -0400
In-Reply-To: <CAB4xu_3e6C-1ELJH-M-otbpqXzh9QeN_=8-t0guzLSiA9F8DNw@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org



On 03/15/2015 10:31 PM, Philippe Proulx wrote:
> On Sun, Mar 15, 2015 at 5:25 PM, Dominik Taborsky <bremby@seznam.cz> wrote:
>> Hello,
>>
>> I am working on a project that involves generating CTF metadata, but I am
>> unsure about how to proceed. I am not sure about how to get information
>> about types,
>
> What "types" are you talking about exactly? What are you intending to
> write to binary streams?

Oh, sorry for not specifying exactly: I mean any defined, non-standard 
types. For example, when you do:

typedef uint32_t key_t;
typedef struct {
	size_t len;
	char *data;
} wire_data_t;

You use these types by their typedef'd name. Suppose then, you want to 
trace a function like:

int do_work(key_t k, wire_data_t data);

Then how do you know what those types are without looking at the 
typedefs? The runtime tracer does not have access to those header files. 
And even if it did, there may be tons of layers of typedefs. You've got 
to do this at runtime, which obviously leaves me with DWARF. Otherwise 
I'd have to specify the type info myself before or after the trace.

So my main question is: how does the LTTng linux kernel module 
understand all the types so it may describe them in the CTF metadata?


Dominik

>
> Phil
>
>> i.e. their size, signedness, alignment and possibly other. I
>> know this information can be gathered from DWARF. Is that the primary way to
>> do this? Is there any other, reasonable way? Can you point me at some code
>> that does this? How does the LTTng linux kernel module work?
>>
>> Thanks.
>>
>> Dominik
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
