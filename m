From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [RELEASE] LTTng-Tools 2.6.0-rc1 - Gaia
Date: Mon, 20 Oct 2014 13:40:14 -0400
Message-ID: <CAFXXi0=8=Pk3pBxQCJSkZMdUKuBo-3vxYK++Um-YZTbZ_zN3AA__3045.5140084543$1413826908$gmane$org@mail.gmail.com>
References: <20141020172654.GE15954@thessa>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <thundersim@gmail.com>) id 1XgGws-0005JR-Fb
 for lttng-dev@lists.lttng.org; Mon, 20 Oct 2014 13:40:56 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so5072232igc.6
 for <lttng-dev@lists.lttng.org>; Mon, 20 Oct 2014 10:40:44 -0700 (PDT)
In-Reply-To: <20141020172654.GE15954@thessa>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> Note that there are now new lines for parsing efficiency. You can find the XML

I think you meant there are _no_ new lines! With the typo, it means
the exact opposite. :)

A small tip for those who are going to work with the MI, use xmllint
to format the output nicely when you want to read it with your eyes:

$ lttng  --mi xml version | xmllint --format -

> schema in "src/common/mi_lttng.xsd". Big thanks to Jonathan Rajotte for this
> great feature that the lttng bash completion file has already started using it!
