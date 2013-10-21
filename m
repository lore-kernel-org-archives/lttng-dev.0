From: Vlad <vlad@demoninsight.com>
Subject: CTF: trying to understand "missing fields"
Date: Mon, 21 Oct 2013 18:53:21 -0400
Message-ID: <D45D38CA-AFA7-41E7-8D63-BDD96DBA4E42__32057.9825355255$1382396072$gmane$org@demoninsight.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <vlad@demoninsight.com>) id 1VYOLq-0005wZ-7C
	for lttng-dev@lists.lttng.org; Mon, 21 Oct 2013 18:53:36 -0400
Received: by mail-qa0-f51.google.com with SMTP id ii20so2869393qab.3
	for <lttng-dev@lists.lttng.org>; Mon, 21 Oct 2013 15:53:24 -0700 (PDT)
Received: from [10.52.5.106] (msmc-64-72-75-194.customer.hvdata.net.
	[64.72.75.194])
	by mx.google.com with ESMTPSA id d7sm42976067qas.10.2013.10.21.15.53.22
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 21 Oct 2013 15:53:23 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Greetings,

	The CTF spec contains a couple of mentions of how one could define a missing field bitmask:

"The header is extended in the rare occasions where the information cannot be
represented in the ranges available in the standard event header. They are also
used in the rare occasions where the data required for a field could not be
collected: the flag corresponding to the missing field within the missing_fields
array is then set to 1"

and

"An example of event-specific event context is to declare a bitmap of missing
fields, only appended after the stream event context if the extended event
header is selected. NR_FIELDS is the number of fields within the event (a
numeric value).

  event {
    context = struct {
      variant <id> {
        struct { } compact;
        struct {
          uint1_t missing_fields[NR_FIELDS]; /* missing event fields bitmap */
        } extended;
      } v;
    };
    ...
  }"

Is this capability reflected in the current lttng builds? My understanding so far is that "missingness" is not part of CTF grammar per se but is rather a convention (i.e. declaring an array of uint1_t's with a particular name "missing_fields") -- is this correct? In the extended header example above, how is a missing_fields slot mapped to its corresponding field -- are the fields assumed to be ordered, with a slot per field in that ordering?

To give some context for my use case:

- I generate my own binary data and I would like to leverage TMF and/or babeltrace to view it
- my in-memory event format is roughly <event ID> + <missing field bitmap> + <fields that are present> (with certain alignment constraints) and I would like to understand whether I can describe it using CTF
- in principle, I can post-process my data as needed so it fits some CTF grammar but I simply don't quite understand how this missing fields feature works

Any help would be much appreciated. 

Thanks,
Vlad
