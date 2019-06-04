From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Need help in converting trace data into CTF
Date: Tue, 4 Jun 2019 10:39:17 -0400
Message-ID: <20190604143917.GA13240__4296.67950827337$1559659179$gmane$org@joraj-alpa>
References: <CAEWVvOSE6QJQvQEdTLEhNQTE7H1Py1ggoqynSj3w-uOYBkTMCQ@mail.gmail.com>
 <72388180.2647.1558032721255.JavaMail.zimbra@efficios.com>
 <CAEWVvOS6WyAkE+5GAyn_WEoFW_6h_fWbze-im0w7oqvXS-+dBw@mail.gmail.com>
 <1448366760.18406.1559146893765.JavaMail.zimbra@efficios.com>
 <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45JF1Q4220zyTM
 for <lttng-dev@lists.lttng.org>; Tue,  4 Jun 2019 10:39:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Ravindra Kumar Meena <rmeena840@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

HI Ravindra,

On Tue, Jun 04, 2019 at 12:02:08PM +0530, Ravindra Kumar Meena wrote:
> Hi developers,
> 
> I have been selected at GSoC 2019. This is my project
> https://devel.rtems.org/ticket/3696.
> 
> The objective of the project is to convert the current trace data into CTF.
> After discussion with you all, I have managed to store the current trace
> data into the disk. Now I have to convert it to CTF.
> 
> I have attached the stored current trace data file. Please find it in the
> attachment.
> 
> I used "nc 169.254.12.97 1234 > rtems_record.out" command to store the
> current trace data. Here 169.254.12.97 is IP address of QEMU target and
> 1234 is port of QEMU target.
> 
> Any idea how I can convert it to CTF?

This was already discussed with you.

https://lists.lttng.org/pipermail/lttng-dev/2019-May/028946.html

You will have to write a decoder (source plugin) for whatever is produced as a
trace output.

See this dmesg source plugin for a base example of a source plugin [1]. This is
valid for babeltrace 2.0 only (AKA the current master branch of babeltrace)

For a more complete example of a source plugin,  you can take a look at the one for
ctf [2]. Once a source plugin is done you will be able to reuse all the current
infrastructure of babeltrace to output to ctf (ctf.sink).

There is no magic solution here, you will need to write a decoder (source
plugin) for your format.

[1] https://github.com/efficios/babeltrace/tree/master/plugins/text/dmesg
[2] https://github.com/efficios/babeltrace/tree/master/plugins/ctf/fs-src

> 
> Thanks
> 
> 
> On Wed, May 29, 2019 at 9:58 PM Ravindra Kumar Meena <rmeena840@gmail.com>
> wrote:
> 
> > With babeltrace 1.5.x: No.
> >>
> >
> > Okay
> >
> >>
> >>
> >> With babeltrace master branch (currently in -pre stage before 2.0): Yes.
> >>
> > Okay. That's great!!
> > Are there examples available on it?
> >
> > Can the conversion be done directly via command-line?
> >
> > Thanks
> >
> >
> >
> >
> > --
> > *Ravindra Kumar Meena*,
> > B. Tech. Computer Science and Engineering,
> > Indian Institute of Technology (Indian School of Mines)
> > <https://www.iitism.ac.in/>, Dhanbad
> >
> 
> 
> -- 
> *Ravindra Kumar Meena*,
> B. Tech. Computer Science and Engineering,
> Indian Institute of Technology (Indian School of Mines)
> <https://www.iitism.ac.in/>, Dhanbad


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
