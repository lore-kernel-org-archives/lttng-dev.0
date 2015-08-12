From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Using LLTNG within shared library (not dlopen-ed).
Date: Tue, 11 Aug 2015 20:30:01 -0400
Message-ID: <CAB4xu_1wg_avoD4CaHUhz8ASzhm06Wt8PXbnRKcQHKeqgnyOpA__10599.7097831734$1439339493$gmane$org@mail.gmail.com>
References: <CAAeL1MGw9i1yHyxpAfJOq++zsNYM7+-_aJDAh2yN1B9k9K3U0w@mail.gmail.com>
 <CAB4xu_0p4cHO4Wtnn4DNNM_8iwVk7U_nNfu=PpNtsLDy-Ob03A@mail.gmail.com>
 <CAAeL1MHVMgmYoOHFjhSumP=hdFuMofXSPpvN6j7fAeUvXVa2xA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1ZPJwC-0001xC-J9
 for lttng-dev@lists.lttng.org; Tue, 11 Aug 2015 20:30:39 -0400
Received: by labd1 with SMTP id d1so831780lab.1
 for <lttng-dev@lists.lttng.org>; Tue, 11 Aug 2015 17:30:30 -0700 (PDT)
In-Reply-To: <CAAeL1MHVMgmYoOHFjhSumP=hdFuMofXSPpvN6j7fAeUvXVa2xA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sergei Dyshel <qyron.private@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Aug 10, 2015 at 4:18 PM, Sergei Dyshel <qyron.private@gmail.com> wrote:
> Hi Phillipe,
>
> Thank you for quick answer! I studied that thread but I see that it refers
> to well-known "dlclose" problem: trace provider as part of dlclose-ed .so is
> unloaded before lttng-ust is unloaded which leads to segfault.
>
> But in my case both .so containing tracepoints (and trace provider) and
> lttng-ust are linked to application at link-time. So both are supposed load
> before application starts and unload after it ends.

It turns out that TRACEPOINT_PROBE_DYNAMIC_LINKAGE should only be
defined when using LD_PRELOAD or dlopen(). In your case, the tracepoint
provider is linked to the application and loaded at runtime.

Would you please try to not define TRACEPOINT_PROBE_DYNAMIC_LINKAGE
and see if it works?

The documentation (online and man page) should probably be updated.

Phil

>
> Also, it would be very inconvenient for me to put trace provider into
> separate ".so" for some reasons.
>
>
> --
> Regards,
> Sergei Dyshel
>
> On Mon, Aug 10, 2015 at 10:52 PM, Philippe Proulx <eeppeliteloop@gmail.com>
> wrote:
>>
>> On Mon, Aug 10, 2015 at 1:27 PM, Sergei Dyshel <qyron.private@gmail.com>
>> wrote:
>> > Hi all,
>> >
>> > I have some code using traces compiled as shared object (together with
>> > trace
>> > provider).
>> > This ".so" is linked to main code during compile-time.
>> > When I run main application and try to read traces after that I get
>> > errors
>> > about corrupted trace file.
>> >
>> > I've read docs about dynamical linking of trace provider which
>> > recommends
>> > compiling trace provider into separate .so and using LD_PRELOAD to
>> > preload
>> > it. But that is only needed for shared objects loaded with "dlopen". In
>> > my
>> > case "dlclose" isn't called and shared object is unloaded on the exit
>> > (i.e.
>> > after all traces produced).
>> >
>> > So this shouldn't be a problem... Am I right?
>>
>> Hello there,
>>
>> See if this thread helps:
>> <http://lists.lttng.org/pipermail/lttng-dev/2014-December/023953.html>.
>>
>> I'm not the author of LTTng-UST and I do not have a comprehensive
>> understanding
>> of its inner mechanics, but I believe that it's good practice to always
>> use
>> LD_PRELOAD with a tracepoint provider that is not statically linked with
>> the
>> application.
>>
>> Phil
>>
>> > --
>> > Regards,
>> > Sergei Dyshel
>> >
>> > _______________________________________________
>> > lttng-dev mailing list
>> > lttng-dev@lists.lttng.org
>> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>> >
>
>
