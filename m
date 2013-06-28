From: David Goulet <dgoulet@efficios.com>
Subject: Re: Lttng Tools 2.2.0
Date: Fri, 28 Jun 2013 16:19:16 -0400
Message-ID: <51CDEFC4.50008__38521.6826609851$1372450812$gmane$org@efficios.com>
References: <51CDC762.5050002@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1Usf8d-0007yg-Tw
	for lttng-dev@lists.lttng.org; Fri, 28 Jun 2013 16:19:24 -0400
In-Reply-To: <51CDC762.5050002@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Simon Delisle <simon.delisle@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

CCing lttng-dev mailing list.

Simon Delisle:
> Hi,
> 
> I work  with the tracing team at Ericsson and I actually work on the lttng 2.2
> support in TMF, but I have two questions about the new feature.
> 1) Does the periodical metadata flush is only for UST or it work for kernel to ?

Both.

> 2) What are the parameter for enable-channel command for the metadata ?

$ lttng enable-channel metadata ...

David

> 
> Thank you
> 
> 
> Ericsson <http://www.ericsson.com/>
> 
> *SIMON DELISLE*
> Software Developer Co-op
> QSI
> 
> *Ericsson*
> 8400 Decarie Blvd
> Town of Mount-Royal, Qc, H4P 2N2, Canada
> Phone 514-345-7900 x45931
> simon.delisle@ericsson.com <mailto:simon.delisle@ericsson.com>
> www.ericsson.com <http://www.ericsson.com/>
> 
> Ericsson <http://www.ericsson.com/current_campaign>
> 
> Legal entity: Ericsson EMC, registered office in Canada. This Communication is
> Confidential. We only send and receive email on the basis of the terms set out
> at www.ericsson.com/email_disclaimer
> 
