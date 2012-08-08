From: David Goulet <david.goulet@polymtl.ca>
Subject: Re: [RFC] LTTng address API proposal v3
Date: Wed, 08 Aug 2012 16:48:01 -0400
Message-ID: <5022D081.3080805__18690.7651754611$1344458908$gmane$org@polymtl.ca>
References: <502167DF.5000806@efficios.com> <50229F21.4080400@efficios.com>
	<5022CF41.9030605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([213.239.202.151])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <david.goulet@polymtl.ca>) id 1SzDAh-00034q-KE
	for lttng-dev@lists.lttng.org; Wed, 08 Aug 2012 16:48:03 -0400
In-Reply-To: <5022CF41.9030605@gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Yannick Brosseau <yannick.brosseau@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



Yannick Brosseau:
> 
> On 2012-08-08 13:17, David Goulet wrote:
>> ADDENDUM:
> 
>> The set_consumer_url() call needs an extra arguments since we can
>> both set the CONTROL or STREAM path using this call (the stream
>> type).
> 
>> So, I would like to propose a change:
> 
>> From: lttng_set_consumer_url(struct lttng_handle *handle, const
>> char *url);
> 
>> To: lttng_set_consumer_url(struct lttng_handle *handle, const
>> char *url, enum lttng_url_stream_type stype);
> 
>> With: enum lttng_url_stream_type { LTTNG_STREAM_CONTROL, 
>> LTTNG_STREAM_DATA, LTTNG_STREAM_ALL, };
> 
>> An _url_ argument with "net://localhost" for instance implies 
>> LTTNG_STREAM_ALL as a type however with "tcp://", we have to
>> specify it.
> 
>> The second possible idea is to add specialize calls like:
> 
>> set_consumer_control_url() set_consumer_stream_url()
> 
> Just brainstorming: lttng_set_consumer_url(struct lttng_handle
> *handle, const char *control_url, const char *data_url)

Just a bit difficult when you have --control-url and --data-url option
possible on the command line... pass NULL to one to set only one.. ?
so this call *can* accept NULL value of one of the arg ?

David

> 
> Yannick
> 
> 
> _______________________________________________ lttng-dev mailing
> list lttng-dev@lists.lttng.org 
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJQItCBAAoJEELoaioR9I02fJ4H/R213HDtvvu4hbcciu/4mxLR
XlDaz3nIWmxPVcpJSiHnEChMjCD1aRh40aUdVbnG5gd/L3MGXV7dbmu/XCcH5OSo
gLzk/T86ijvobjgFE6bwXFdGWxCoLTuTk2buzb1v1ppVLC9NeBo8W8wkPURYCR5+
ACFOAMY12X2p543hkp1/B6VSCjdrED59s9QPHpWE4i4FIBSMQrXrXOLLHUwbIrhq
x4/14HFYDLkPJeLDOQezbvW1r6B0yovU+NDWimiyr2uG5CPO1Rp5fGl8wjQTh8p+
gcnigccnrONW2ZjQnKlDFeGQmMq8Werznm5QBc38E3SA0+N8BRNRRqoKqqNpsUE=
=DUoy
-----END PGP SIGNATURE-----
