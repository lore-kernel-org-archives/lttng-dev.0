Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E37FC433F5
	for <lttng-dev@archiver.kernel.org>; Tue, 31 May 2022 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1653997867;
	bh=YyNGFRSUi7a2Hgmee+fu9N9qDPkZTtiR37WV6AoAx0A=;
	h=Date:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=qLGvhacWPjqu/2KfKTxQ6duGbttaWTxO76igREhk86Uxar5LWN+o6rvoVh6zTIeyV
	 bf/2A7vqlXhogdWrtFzxoul7vb64GaD2yGxUZnr7/l1gR4v/6D974d2b/5m+9Fczzn
	 /C78I7sbysCk7l/9YZGbiwku49ojGlDWD7b+cmHRSAEZAbwsujW/8eKom1pRUqrqkz
	 yC39rXh+vcWoOtJa8H2qxNosgC151kFtwZqGQHUeod5dkfskZxOlsN/f6CnnJMLFgL
	 LV+4yzT+ldYW6yRZOWJaIkjoOf+LIfGyZl+kWPbwv1AawweIcg/1ieoXstC5h2iOfB
	 ssbnyV/kVJmxQ==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4LC9bH1mBtz3qZ;
	Tue, 31 May 2022 07:51:07 -0400 (EDT)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by lists.lttng.org (Postfix) with ESMTPS id 4LC9bG2QXlz3Yg
 for <lttng-dev@lists.lttng.org>; Tue, 31 May 2022 07:51:06 -0400 (EDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
 by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VAnVHa010802;
 Tue, 31 May 2022 11:28:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
 by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3gbbxk9y5g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 31 May 2022 11:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hasBfsPy+rvJ6KGUP333D78osVCd6JuHQBidZ3RbpOpT2JESdNunXTMa8NqANKSe7kxJIh4CXSCkcZfS3A9WDMoGaY22qOYsDE4vfknex9wFcjM2ROSoIvXQqJoZTPkdSnEGbXZrajssP2ggn5IxH4ouMN1rnUTtui9faScpF3ptR+PZxpMsfuoXAGAb90jWM6qwGtNlD/iQFlH2d+gzVrq5xZ1mfG7SlGmR/+TTttk9YWJLDiQTRrQPoJKpFPywhxQaK1JWxnTGwWtS2hUBvfQVg5ef847QVZnNekmOs7VFx6K5YjryqyRAnyHW2272r3N5ZUfe0zy8T6Y9jPKFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfD1swlLddZkQ/LOPgmmSH6fqZ6+sWAYdI7XTfsWIlI=;
 b=WdBw4wZ0U/K8nzbZvxusvN99tfRGiFYq1E8q4u98DsyyoTwGoFYWdFqjmtUrEGhh2/FdZFA693uXGV/ve+yGU0eFyiQ66tpx3O2eQJCJgNCvGFGyt55CnJuD0eOG+l8Zk+J2/evduWwPIyq0tI/DypWlZ2B6ufw9CXYa/xkqeyeInZIIXdotx1NNOs8/P7IZW7su6gO+YtS29YdojRpWWk1Qg1XSbzpw0o79Ff1v8tli+L4/Cwzj7SpInjc/QcAyZUfFZiwPtII9GxF3xu4e64I/tKyBxwZRzkicj2u+Y4BhIT+Fba2faSBC3+ko7KIfAImExgu+eIh2ZnxEJYHHWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14)
 by CH2PR11MB4200.namprd11.prod.outlook.com (2603:10b6:610:3d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 11:28:26 +0000
Received: from CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8]) by CO6PR11MB5617.namprd11.prod.outlook.com
 ([fe80::f9a6:f09b:36b5:46f8%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 11:28:26 +0000
Date: Tue, 31 May 2022 13:28:55 +0200
To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <20220531112855.GA856582@windriver.com>
References: <20220530141021.267219-1-marcel.hamer@windriver.com>
 <769020238.11656.1653924475516.JavaMail.zimbra@efficios.com>
Content-Disposition: inline
In-Reply-To: <769020238.11656.1653924475516.JavaMail.zimbra@efficios.com>
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To CO6PR11MB5617.namprd11.prod.outlook.com
 (2603:10b6:5:35c::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13bcc389-18c1-4c44-dcbb-08da42f8ad90
X-MS-TrafficTypeDiagnostic: CH2PR11MB4200:EE_
X-Microsoft-Antispam-PRVS: <CH2PR11MB4200EC0FB4E8105622475E0692DC9@CH2PR11MB4200.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBjl8ehVvys5F4SnzJ1A+h5Z+0ShFkyrE8ZzzzhMRpsLmty7RbchOo9dhZ6EUVe1tRP6/TwEoK7jrvKvz+HOYbAks+biASBVtsr8qXEG/GWc/oNyixAXPJE9hXgdAPHQXCSSS3QddGjxZuVbgDEvTNUNNqJQrJ+mo6uou1VGzK3IV8Q4VkDKO401SoRQ/Kv3+2rTv5V6vAd4h1rxGfmSyxM2w8gTfF2FgK666y9l3RAiIR2albYSfYJAIqqe8jb5D6cDf808RZU2h1dbxqM/eRgcrV23CpW/D6Z+lxNJ8uQ1ZTaCjtQI+lpybx/mBOeAqvZ+p5pxv0uDf8JKhNECBj1hu1z8yU5tQ5E5f9TcCspTbb1tPWkxKQC74z1NOZIyonBa+B+034NQsvi3kNZsezfqh/LYBPUI567jD0TPeijaAC5A/3oijbYj41MjovMMO+d2kRjUbeW5fXGfkJWwjGrr4PgUAAXi/G7JmhkjaNeSq2MaR4x6xkQiZ+k3cOLb5WexS8TAqa5/v+jmKCD2UI7Cvqhotk/qZ/K8zL4qujx8x1WMp7IIw5Nil6Cnb8Xduw4iRoTzL4Y3qiEef4P7mLh5pd1HDvpo9iDrdvfTy5FbrPw/VjF/7iTQI7eaq52O8aPpn8sK7/WH6lYiO5E5GYVto3+r3ZkiwHaZXj5BFe+jp1sYKu7HBLLpngw7gTwpnSnYchLqjQgsALKYprkOj9l7w/Kk4pvj5tSMp3gIWl73se5mVVpSzRvclkGfeXP8B0/86xpeUS1Pj0bPlIngSz4+MeccMCr0KUx6yNABEHaTbyNvOz7VgvFpboBUHW76
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR11MB5617.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38350700002)(6666004)(66556008)(66946007)(66476007)(4326008)(8676002)(38100700002)(6916009)(8936002)(316002)(36756003)(86362001)(1076003)(52116002)(966005)(6506007)(186003)(26005)(508600001)(5660300002)(6512007)(6486002)(2906002)(44832011)(53546011)(2616005)(83380400001)(33656002)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZVW3ACsSdM6nGBi1DjPrttmUD6mRd/2MpjGakUcysgtCImG/n6FK9bWGOIp?=
 =?us-ascii?Q?xJwazRLr58acqNwFJfpPF1lIvoEeBZo6MI4b2NgqTTUmShrHgK6b/ZKwTBb8?=
 =?us-ascii?Q?BNmmKxnvyyXhPMp6EfXWi6TUM6gWLmJxNukKc1Zz9/p6QutPgYGMj4LmXdLO?=
 =?us-ascii?Q?kFW1Qgdr5CwjTqMuRItJsw0YEfYj0DWyhYVvxthpdnuieAz8VGWsbwtLdZN9?=
 =?us-ascii?Q?FxonFdG3GyKAYvbgWeLSFojwhnwVPFTQbf8tNIBNPcL7o339lU4eD3gcmrEz?=
 =?us-ascii?Q?EuNJFNwKgP9+yMHqKnQbYY09y0dQ9p9K0uvks2qSX+rDbAN+5Y6QlLnTFUHT?=
 =?us-ascii?Q?z+wytFsFg5AdD9jtW0ZnxcQJqIlRzBtAxef3V0VRwYrca+Nv4VdNf2mnmolE?=
 =?us-ascii?Q?6DxwP8/P/pH+07DyUmKs4ldGyxpn+opoCMvu/7CMQQtzHva8mh1EuYSBm47G?=
 =?us-ascii?Q?NRwbrN4ADRYqsW2DgpQ73T+9Z05XyD36jT8rBDEChHxUkK5mPOyYYsv/J0q9?=
 =?us-ascii?Q?zCeR3WaUnlSN5YgQ3l88ETSQhYU5xUjHZDIlppCp+CcENLoFbXhydW7Wci9P?=
 =?us-ascii?Q?cIt+JEKKo1eb4/rB283qBxeL1wHKx3bv9cwhrcbeQxAXPYGNFbHmJ/jBhJ2v?=
 =?us-ascii?Q?sO1Km0hIxayYkWq1SUbtgupw0uOKzLjSIr7pJ0Np+lnfspXcnro5q/jg1sMp?=
 =?us-ascii?Q?lMMj8xqHQr50sgjkdTnR3htRAqp4KUDi0R9WjUu6Y8I2/1x1xSCn2eLyLWGU?=
 =?us-ascii?Q?4AcQmznKWrX7RSQP9rkHGQoUspD3t0BeGrTeanyDLuTu0klt6pvkGETbVCfQ?=
 =?us-ascii?Q?TWywrKgowwKXOrIL8OPAa/55QUhEiTMh3D54b73TP2h/YtsCGUe492F+y+ZJ?=
 =?us-ascii?Q?d0G7fuvifw9vKk0v41N+Qxzm/Uf1Bu4qHbm63HnIx/2oQwqAsWZDBAkdFxrq?=
 =?us-ascii?Q?crnh8oWZAojUNOflrJewZa07FDLguVMKXyaqYzs2uU+R9YXI8iUd8gk4Kcay?=
 =?us-ascii?Q?cVCMfI0/6KVIt67pZX+OtDwrwfJ+rjb2hjJUHcsCAdCDpiSg2lsnGZm1kHpX?=
 =?us-ascii?Q?1azTmZfAEGp4fEkQuHcjmtRPnS6Efc4Wtm3EvFRq4YUuxCwA9CKPtsdtO/4j?=
 =?us-ascii?Q?m/0ps0QQQS19M4FaS4gSrzCAU34V+sBhvWu/YqQ8rXf3lOm2dIUx17LHSpsG?=
 =?us-ascii?Q?G38El8kFLFPn/P/3/WBwWcItdxo4A5Mwa04Csz0jWNiAGOj2pLJSPt0acREw?=
 =?us-ascii?Q?ftmBuODIOh/l5pHntD6dvvt9wGyDjzhMoAefzgJcxPMbVe4N/WYH5mWqMdOh?=
 =?us-ascii?Q?EblbfS0M1ykQT/6pTOKfTnWgx8Cdu4j6t+UI7qHnVolNpFW82ldx2a3eao0w?=
 =?us-ascii?Q?VvOuEqFMhngtaXlP3rOdsRN38gPjpAjKiLyVd+8BuVlN7BXJz3n5FcPtKnGd?=
 =?us-ascii?Q?iXKJRpX/rAuFfkf5ibxzfEzgHTGuVwJ8pXW8dQB+kGj6eZaKZwnwx8S0fWIo?=
 =?us-ascii?Q?J9ZtXjnpr7xyu7xgbqMVc5KGGbfZqTULxlrPQtiuVZUagrVES/iqLhn9V70k?=
 =?us-ascii?Q?lXE2fma/GMp8fu0sfjGh76kcf1TSghlOY4T/IiLoa/n6lCY2pOC1kptEPQ5M?=
 =?us-ascii?Q?3+pJDNS3wWjPaSNMwwKvuYiEGKIwoMosJHnfOq4R3ArYK0aJZIvgB48SOz9S?=
 =?us-ascii?Q?KCb3TPnUWqx0OFhukY9GU6J0ZfNguMkR1pTz+JUNwvvJwuzg3ag5S7kXFjC9?=
 =?us-ascii?Q?Vpq8pn6D+VgJyKdCIVHjUhLADeKDkJE=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bcc389-18c1-4c44-dcbb-08da42f8ad90
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5617.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 11:28:26.1214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBjBYlyaiLdkW8yvKW8ahvjWGojEi3bi9r5QaxZNUiyeBBIlznKg9AMQYQkUYa60C15xK6+onuKF4KJq3bpq9DZN7i9fODTBvmLARi5dwJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4200
X-Proofpoint-GUID: MfeQzw-47j26rxGCaoXg97C5nKU3S9Wk
X-Proofpoint-ORIG-GUID: MfeQzw-47j26rxGCaoXg97C5nKU3S9Wk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-05-31_04,2022-05-30_03,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205310059
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: cleanup stream on snapshot
 failure
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Marcel Hamer via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Marcel Hamer <marcel.hamer@windriver.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hello Jonathan,

On Mon, May 30, 2022 at 11:27:55AM -0400, Jonathan Rajotte-Julien wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hi Marcel,
> 
> Thanks for sending this patch.
> 
> Looks sensible to me, still do you have a reproducer for it? I went back to bug 1352 and even with https://bugs.lttng.org/attachments/546 was unable to force the assert failure.

I can only reproduce it when running lttng-consumerd in a debugger
environment, in my case gdb. My reproduction scenario is:

1. Setting a breakpoint on snapshot_channel() inside
   src/common/ust-consumer/ust-consumer.c
2. When the breakpoint hits, remove the the complete lttng directory
   containing the session data.
3. Continue the lttng_consumerd process from gdb.
4. In that case you see a negative return value -1 from
   consumer_stream_create_output_files() inside snapshot_channel().
5. Take another snapshot and you will see lttng_consumerd crash because
   of the assert(!stream->trace_chunk); inside snapshot_channel(). This
   last action does not require any breakpoint intervention.

The scenario seems to be very timing sensitive to reproduce. I do not
have a clear command sequence to achieve the same error.

The proposed patch prevents lttng_consumerd from crashing in step 5.

Kind regards,

Marcel

> 
> Cheers
> 
> ----- Original Message -----
> > From: "Marcel Hamer via lttng-dev" <lttng-dev@lists.lttng.org>
> > To: "lttng-dev" <lttng-dev@lists.lttng.org>
> > Sent: Monday, 30 May, 2022 10:10:21
> > Subject: [lttng-dev] [PATCH lttng-tools] Fix: cleanup stream on snapshot failure
> 
> > When a channel snapshot creation fails the stream should be cleaned up
> > properly. If the stream is not closed and cleaned properly on a failure,
> > the next time a snapshot is created an assert is triggered for:
> >
> >       assert(!stream->trace_chunk);
> >
> > inside the snapshot_channel function. Since the stream->trace_chunk was
> > not reset to NULL. The reset to NULL happens inside the
> > consumer_stream_close function.
> >
> > Fixes #1352
> >
> > Signed-off-by: Marcel Hamer <marcel.hamer@windriver.com>
> > ---
> > src/common/ust-consumer/ust-consumer.c | 10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/common/ust-consumer/ust-consumer.c
> > b/src/common/ust-consumer/ust-consumer.c
> > index f176ca40a..f43216829 100644
> > --- a/src/common/ust-consumer/ust-consumer.c
> > +++ b/src/common/ust-consumer/ust-consumer.c
> > @@ -1147,13 +1147,13 @@ static int snapshot_channel(struct
> > lttng_consumer_channel *channel,
> >               if (use_relayd) {
> >                       ret = consumer_send_relayd_stream(stream, path);
> >                       if (ret < 0) {
> > -                             goto error_unlock;
> > +                             goto error_close_stream;
> >                       }
> >               } else {
> >                       ret = consumer_stream_create_output_files(stream,
> >                                       false);
> >                       if (ret < 0) {
> > -                             goto error_unlock;
> > +                             goto error_close_stream;
> >                       }
> >                       DBG("UST consumer snapshot stream (%" PRIu64 ")",
> >                                       stream->key);
> > @@ -1170,19 +1170,19 @@ static int snapshot_channel(struct
> > lttng_consumer_channel *channel,
> >               ret = lttng_ustconsumer_take_snapshot(stream);
> >               if (ret < 0) {
> >                       ERR("Taking UST snapshot");
> > -                     goto error_unlock;
> > +                     goto error_close_stream;
> >               }
> >
> >               ret = lttng_ustconsumer_get_produced_snapshot(stream, &produced_pos);
> >               if (ret < 0) {
> >                       ERR("Produced UST snapshot position");
> > -                     goto error_unlock;
> > +                     goto error_close_stream;
> >               }
> >
> >               ret = lttng_ustconsumer_get_consumed_snapshot(stream, &consumed_pos);
> >               if (ret < 0) {
> >                       ERR("Consumerd UST snapshot position");
> > -                     goto error_unlock;
> > +                     goto error_close_stream;
> >               }
> >
> >               /*
> > --
> > 2.25.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
