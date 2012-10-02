From: David Goulet <dgoulet@efficios.com>
Subject: Re: lttng destroy fails
Date: Tue, 02 Oct 2012 15:11:40 -0400
Message-ID: <506B3C6C.5030605__38888.0792110742$1349205170$gmane$org@efficios.com>
References: <506B36BB.4040808@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1TJ7sc-0004gC-KP
	for lttng-dev@lists.lttng.org; Tue, 02 Oct 2012 15:11:42 -0400
In-Reply-To: <506B36BB.4040808@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Bernd,

I've just created a new issue about that.

https://bugs.lttng.org/issues/359

Thanks for reporting!
David

Bernd Hufmann:
> Hello
> 
> I noticed a minor issue when executing the following command sequence:
> 
>> lttng create auto
> Session auto created.
> Traces will be written in /home/bernd/lttng-traces/auto-20121002-144207
>> lttng destroy
> Warning: Session name auto not found
> 
> The session is sill around after that. I think the problem is that in
> the file .lttngrc the wrong session name is stored. In the file .lttngrc
> the session name "auto" is stored but the actual name is
> "auto-20121002-144207".
> 
> BTW, I'm using lttng-tools 2.1 RC4.
> 
> BR,
> Bernd
> 
