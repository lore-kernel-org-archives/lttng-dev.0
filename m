From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Need help in converting trace data into CTF
Date: Wed, 19 Jun 2019 13:10:57 -0400
Message-ID: <20190619171057.GB32505__15215.3030548774$1560964280$gmane$org@joraj-alpa>
References: <CAEWVvOSdmSsfGiN2fd7yAO6m5-Ke=GuamNR6jKYCLRnSym9Hcw@mail.gmail.com>
 <CAEWVvOSorZyz=JOaf-7go-EyZxcmiOzcVbnUpb7crdKM_SVejA@mail.gmail.com>
 <20190604143917.GA13240@joraj-alpa>
 <20190604145312.GB13240@joraj-alpa>
 <CAEWVvORHWTQLe_uhw2M+aT6tEjgdz3emfxEUosbo+bMsqdN=QA@mail.gmail.com>
 <CAEWVvOR0wv2Du2KNCZE0dpNAhMaFh7JvDFG0FOQ8uWyTBpSoOw@mail.gmail.com>
 <20190617165154.GA7208@joraj-alpa>
 <CAEWVvOSXKF=Ey_edFSFp=CqUDHyhoB_iZQEdTHwcwwYNM3LpJg@mail.gmail.com>
 <20190618141714.GC7208@joraj-alpa>
 <CAEWVvOS-Xe_q7BuPiV7LEJ0Cx96tjsydYALvytvrzg-D+8TYhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45TWgQ6rZkz17XC
 for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2019 13:10:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAEWVvOS-Xe_q7BuPiV7LEJ0Cx96tjsydYALvytvrzg-D+8TYhg@mail.gmail.com>
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

>  I want to make babeltrace read my metadata file and event stream stored in
> a file. How does babeltrace read an arbitrary CTF session(CTF+event stream)?

Babeltrace traverses the tree and look for files named "metadata"
. All files at the same depth of a metadata file are considered CTF streams.

e.g:
   /tmp/
       my-trace/
           another_dir/
               abcd
               efgh
               metadata

babeltrace /tmp/my-trace/

The files "abcd" and "efgh" will be considered stream files and babeltrace will
try to read them.

You can have hidden file (".abcd") at the same depth, they will not be
considered.

> 
> What should be the file format to store the event stream? I will use
> fwrite() to store the events.

The CTF format.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
