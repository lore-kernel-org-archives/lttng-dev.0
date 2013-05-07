From: Aaron Spear <aspear@vmware.com>
Subject: Re: Using the additional Eclipse Kernel Trace Plugin
 Views (Control flow, Resources)
Date: Tue, 7 May 2013 11:49:50 -0700 (PDT)
Message-ID: <652778195.2091532.1367952590522.JavaMail.root__45292.5731348389$1367952640$gmane$org@vmware.com>
References: <517F8D02.4090202@stud.fh-dortmund.de>
	<518004F6.5040202@ericsson.com> <51800F67.9040407@voxpopuli.im>
	<5180D919.1020208@stud.fh-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <aspear@vmware.com>) id 1UZmxY-0004bn-QH
	for lttng-dev@lists.lttng.org; Tue, 07 May 2013 14:49:57 -0400
In-Reply-To: <5180D919.1020208@stud.fh-dortmund.de>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andre Bette <andreb@stud.fh-dortmund.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Andre,

You will probably also want to search the recent traffic on the linuxtools-dev email list as well.  (That is probably the more appropriate forum for questions related to the linuxtools LTTng plugins/Java code)

I recently posted a github link to some work in progress where I did went through the process that Alexandre described to create a completely data driven view to show state over time (though I didn't have the advantage of his explanation!).  I am using it to trace various things such as Java applications as well as state of virtual machines and such over time.  It is not perfect or complete, but it is headed in the right direction.

Here is a link to the list archive: http://dev.eclipse.org/mhonarc/lists/linuxtools-dev/, and a direct link to my post: http://dev.eclipse.org/mhonarc/lists/linuxtools-dev/msg02574.html  Somewhere in that thread are some screenshots and such of what I did with it.

regards,
Aaron Spear


----- Original Message -----
> Hi Alexandre and Matthew,
> 
> Thank you both very much for the detailed answer. If I have more
> questions about some Javacode I will ask later .
> 
> 
> Best Regards,
> Andre
> 
> PS: Sorry for the doublepost
> 
> 
> 
> 
> Am 30.04.2013 20:37, schrieb Alexandre Montplaisir:
> > On 13-04-30 01:52 PM, Matthew Khouzam wrote:
> >> Hi Andre,
> >> This question seems familiar, I will paste an answer from earlier.
> >> On 13-04-30 05:21 AM, Andre Bette wrote:
> >>> Hi to everyone,
> >>> in my project I am tracing a embedded system with a non linux OS.
> >>> Output format is CTF. I really like the two extra views in the Eclipse
> >>> Kernel Trace Visualization (Control flow, Resources).
> >>>
> >>> Is there a simple way to use this two views  with an non linux trace ?
> >>> Is there any documentation about the Linux kernel trace format( the
> >>> extra info added into the CTF format) or how the
> >>> data(e.g. prozesses) is processed in the Eclipse Kernel Trace Plugin
> >>> (The idea is to use a "fake" linux trace to use the two extra views )?
> >>>
> >> I will give a short answer that I am sure Alexandre Montplaisir has
> >> expanded on earlier is  YES!
> > Yeah my first reply bounced, but you can read it here:
> > http://lists.lttng.org/pipermail/lttng-dev/2013-April/020165.html
> >
> > Cheers,
> > Alex
> >
> >> You need to make a state system with a "state system input" that will
> >> emulate the directory structure of the kernel state system.
> >>
> >> It's not EXTREMELY hard, but I think it will get significantly easier in a
> >> couple of months.
> >> Great to hear you like the eclipse viewer, fan mail is always appreciated,
> >> especially in duplicate!
> >>
> >> Matthew
> >>
> >>> Best Regards,
> >>> Andre
> >>>
> >>> _______________________________________________
> >>> lttng-dev mailing list
> >>> lttng-dev@lists.lttng.org
> >>> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >> _______________________________________________
> >> lttng-dev mailing list
> >> lttng-dev@lists.lttng.org
> >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> >
> 
> 
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> 
