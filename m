From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Announcing the new LTTng website
Date: Mon, 13 Oct 2014 00:20:49 -0400
Message-ID: <CAB4xu_3OYS0jBELJ5x=hZhWQ60DbiG0ZsuZF83yS3tDVCOq-cA__44374.3325457492$1413174137$gmane$org@mail.gmail.com>
References: <CAGDH53m0FqrsbOStwjKNZoqjM=W=MKpspJS6EX2rC3mAKpyj0A@mail.gmail.com>
 <5439E195.2000107@voxpopuli.im>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1XdX8R-0000N3-Cr
 for lttng-dev@lists.lttng.org; Mon, 13 Oct 2014 00:21:30 -0400
Received: by mail-qa0-f48.google.com with SMTP id dc16so3988878qab.35
 for <lttng-dev@lists.lttng.org>; Sun, 12 Oct 2014 21:21:19 -0700 (PDT)
In-Reply-To: <5439E195.2000107@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Sat, Oct 11, 2014 at 10:04 PM, Alexandre Montplaisir
<alexmonthy@voxpopuli.im> wrote:
>
> Hi Christian,
>
> Very nice work! It's very "Web 3.0", I like it!

Thank you Alex. We believe Web 3.0 is the next level.
>
> The documentation page is particularly good. It manages to make doc not look boring!
>
> Other random comments:
>
> apt-get and yum (and zypper too afaik) support more than one package on the command line. On the Downloads page, you could list the different packages to install in one command (like was done for the 'yaourt' command. I sense distro favoritism ;) )

You are right. This is what I did in the first place, but my motivation for
switching from one to multiple lines was to make the reader see the individual
package names at first glance (since they become aligned vertically), as well
as easing select/paste operations to install specific packages. This is also
why all packages are always listed, even when some could be mandatory
dependencies. Yaourt's exclusion is a mere oversight; the LTTng project doesn't
discriminate amongst Linux distributions! :)

So I am open to both options.
>
> On the Viewers page (which is harder to find now, I only found a link in the footer, intended?), it mentions both Trace Compass and the LTTng Eclipse plugin. Those are basically the same thing, Trace Compass is just a move/rename. You could only list Trace Compass, even though it isn't officially "launched" yet, but will be Real Soon(tm).
> Also, the URL should point to eclipse.org/tracecompass instead of the projects.eclipse.org page. Yes, the first one redirects to the second one for now, but this may not always be the case, we will probably have a "real" website at the first link at some point.
>
>
> Cheers,
> Alexandre
>
>
>
> On 2014-10-11 06:39 PM, Christian Babeux wrote:
>>
>> Hi everyone,
>>
>> We have launched a new website for the LTTng project [1]. We have done
>> major improvements on the documentation side of the project. You can
>> now read the documentation at [2].
>>
>> Contributing and improving the documentation is now very easy, just
>> follow the instructions on our Github repo [3].
>>
>> A big thanks to Philippe Proulx who helped design the new website and
>> wrote most of the documentation.
>>
>> Also, I would like to thank Daniel Thibault, from the DRDC, who wrote
>> an open guide that was mostly used to complete parts of the
>> "Understanding LTTng" chapter and for a few passages here and there.
>>
>> Finally, if you encounter any issues using the new website, please let us know!
>>
>> Thanks,
>>
>> Christian
>>
>> [1] - https://lttng.org
>> [2] - https://lttng.org/docs
>> [3] - https://github.com/lttng/lttng-docs
>>
>> _______________________________________________
>> lttng-dev mailing list
>> lttng-dev@lists.lttng.org
>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
