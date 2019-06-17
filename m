From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Need help in converting trace data into CTF
Date: Mon, 17 Jun 2019 13:04:43 -0400
Message-ID: <20190617170443.GB7208__46424.519519654$1560791106$gmane$org@joraj-alpa>
References: <72388180.2647.1558032721255.JavaMail.zimbra@efficios.com>
 <CAEWVvOS6WyAkE+5GAyn_WEoFW_6h_fWbze-im0w7oqvXS-+dBw@mail.gmail.com>
 <1448366760.18406.1559146893765.JavaMail.zimbra@efficios.com>
 <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa>
 <20190604145312.GB13240@joraj-alpa>
 <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA@mail.gmail.com>
 <CAEWVvOR0wv2Du2KNCZE0dpNAhMaFh7JvDFG0FOQ8uWyTBpSoOw@mail.gmail.com>
 <20190617165154.GA7208@joraj-alpa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45SHdG3qr6zypc
 for <lttng-dev@lists.lttng.org>; Mon, 17 Jun 2019 13:04:50 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20190617165154.GA7208@joraj-alpa>
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

Hi,

Note that if you plan on using Babeltrace 2 plugin system, the metadata file
will be generated based on the trace representation given by the source plugin.

See [1] for an example of this.

[1] http://git.efficios.com/?p=babeltrace.git;a=blob;f=src/plugins/text/dmesg/dmesg.c;h=7ed01cdc2f4dcdf64f88541884d26b8787df4760#l122

Cheers

On Mon, Jun 17, 2019 at 12:51:54PM -0400, Jonathan Rajotte-Julien wrote:
> Hi,
> 
> > I am trying to write a metadata file. I am following https://diamon.org/ctf/.
> > I found one metadata file on GitHub repository
> > https://github.com/efficios/epiphany-examples/tree/barectf-tracing/apps/barectf-tracing/ctf
> > 
> >  Which file format is used for the metadata files?
> 
> Babeltrace understand text based metadata file as long as it conforms to the TSDL
> grammar.
> 
> See:
>     https://diamon.org/ctf/#spec7
>     https://diamon.org/ctf/#spec7.4
>     https://diamon.org/ctf/#specC
> 
> For an example of metadata generator, you can look at Barectf[1] or
> lttng-tools[2]
> 
> [1] https://github.com/efficios/barectf/blob/a3ebf5855c025a86ebc2d62cbda1338461e84c5a/barectf/tsdl182gen.py
> [2] https://github.com/lttng/lttng-tools/blob/c8e0c5f5d94fb574f4e5d7518f0f8e6f984dfe3d/src/bin/lttng-sessiond/ust-metadata.c
> 
> -- 
> Jonathan Rajotte-Julien
> EfficiOS

-- 
Jonathan Rajotte-Julien
EfficiOS
