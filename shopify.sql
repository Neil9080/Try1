-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 08, 2023 at 08:57 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `shopify`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `orderid` int(11) NOT NULL,
  `userId` int(11) DEFAULT NULL,
  `prodId` int(12) DEFAULT NULL,
  `qty` int(11) NOT NULL,
  `size` varchar(5) NOT NULL,
  `address` varchar(255) NOT NULL,
  `total` int(11) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `billname` varchar(40) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `status` varchar(20) NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`orderid`, `userId`, `prodId`, `qty`, `size`, `address`, `total`, `phone`, `billname`, `date`, `status`) VALUES
(1, 2, 11, 1, 'XL', 'Baneshwor,EyeplexMall', 1800, '9807655432', 'Alex Costa', '2023-05-06', 'accepted'),
(2, 3, 4, 1, 'XL', 'Tinkune Field', 5000, '9806789654', 'Ana DeArmas', '2023-05-06', 'canceled');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(12) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(20) NOT NULL,
  `stock` int(11) NOT NULL,
  `brand` varchar(255) NOT NULL,
  `stars` int(11) NOT NULL DEFAULT 5,
  `price` int(11) NOT NULL,
  `img` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category`, `stock`, `brand`, `stars`, `price`, `img`, `description`) VALUES
(1, 'Grey Colored High Relaxed Korean Shirt Slim Fit', 'Korean Shirt', 10, 'GentleMonster', 5, 2500, 'Grey Colored High Relaxed Korean Shirt Slim Fitkoreanshirt.jpg', ' A timeless style that exudes elegance and sophistication. Made from soft and durable cotton, this shirt features a button-down collar and a slim fit that flatters any body type.'),
(4, 'Orange Colored Full Formal Outfit For Men', 'Formal', 4, 'Defied', 5, 5000, 'OrangeColoredFullFormalOutfitForMenformalset.jpg', 'This stunning formal dress is sure to turn heads at any special occasion. With its elegant design and luxurious materials, it\'s the perfect choice for a black-tie event or formal wedding.'),
(6, 'Navy Blue Formal Blager', 'Formal', 7, 'Defied', 5, 6000, 'FormalNavyBlueBlagerForMenblager.jpg', 'The dress is made from high-quality materials, including luxurious silk or satin and soft, flowing chiffon. The skirt is lined with a soft, lightweight fabric for comfort and ease of movement.'),
(7, 'Full Balck Custom Coat Double Button', 'Formal', 4, 'Defied', 5, 12000, 'FullBalckCustomCoatDoubleButtoncoat.jpg', 'Make a statement at your next formal event with this stunning formal dress. This dress features a sleek and elegant design that is perfect for any special occasion.'),
(8, 'Green Double Breasted Suit Wedding Premium', 'Formal', 5, 'Etsy', 4, 7000, 'GreenDoubleBreastedSuitWeddingPremiumBespokecoat2.jpg', 'This formal dress is perfect for a range of special occasions, from weddings to charity galas. Pair it with elegant heels and statement jewelry to complete the look, and you\'ll be sure to turn heads wherever you go.'),
(9, 'Korean Full Plain White T-shirt ', 'Korean Shirt', 10, 'GentleMonster', 5, 1200, 'KoreanFullPlainWhiteT-shirtkoreanshirt1.jpg', 'Perfect for a day out in the sun, this lightweight and breezy shirt features intricate embroidery and a relaxed fit. Pair it with shorts and sandals for a casual yet chic look.'),
(11, 'Floral Cool Summer Shirt', 'Floral Shirts', 9, 'Imvely Bell', 5, 1800, 'FloralCoolSummerShirtfloralshirt.jpg', 'Add some color and personality to your wardrobe with this eye-catching shirt. Featuring a vibrant floral print and a slim fit, it\'s perfect for a summer party or a night out.'),
(12, 'Half Sleeve Vertical Strip Shirt', 'Floral Shirts', 10, 'Imvely Bell', 5, 1600, 'HalfSleeveVerticalStripShirthalfsleeve.jpg', 'Ideal for a beach vacation, this airy and comfortable shirt is made from high-quality linen and features classic blue and white stripes.'),
(13, 'Men\'s Asymmetric Tribal Printed Short sleeve', 'T-shirt', 10, 'Fibro', 5, 800, 'Men\'sAsymmetricTribalPrintedShortsleevetshirt2.jpg', 'Add some functionality to your wardrobe with this stylish pocket t-shirt. Featuring a handy pocket on the chest, it\'s perfect for holding your phone or other essentials while on the go.'),
(14, 'Men Cat Print Cotton Short Sleeve T-Shirts', 'T-shirt', 10, 'Fibro', 5, 1200, 'MenCatPrintCottonShortSleeveT-Shirtstshirt1.jpg', 'This versatile t-shirt style features a button-up neckline and a slim, modern fit. Made from high-quality cotton, it\'s perfect for layering under a sweater or jacket or wearing on its own.'),
(15, 'New Slim Fit Cargo Pant', 'Pant', 9, 'LVD', 5, 2200, 'NewSlimFitCargoPantEcommerce images.jpg', 'Stay comfortable and stylish on your next adventure with these versatile cargo pants. Made from high-quality cotton, these pants are durable, breathable, and perfect for outdoor activities.');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `revid` int(11) NOT NULL,
  `userid` int(11) DEFAULT NULL,
  `prodid` int(11) DEFAULT NULL,
  `stars` int(11) NOT NULL,
  `comm` varchar(255) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`revid`, `userid`, `prodid`, `stars`, `comm`, `date`) VALUES
(1, 2, 8, 4, 'This is a premium coat and perfect green', '2023-05-06'),
(2, 2, 11, 5, 'Bought this shirt value for money', '2023-05-06'),
(3, 3, 4, 5, 'Bought this for my brother good', '2023-05-06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `fullname` text NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `img` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `id` int(11) NOT NULL,
  `pin` int(6) NOT NULL,
  `isadmin` int(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`fullname`, `email`, `password`, `img`, `address`, `phone`, `id`, `pin`, `isadmin`) VALUES
('Admin', 'admin@gmail.com', 'cMURa5v+mtEKKC36wa7azzfJyeTdWfcQWy8WwB9R3Lql56LgcBlhiQZ9akaDE5Q6dSfE', 'admin@gmail.combillybutcher.jpg', 'Baneshwor,Kathmandu', '9804894712', 1, 1234, 1),
('Alex Sharma', 'alex12@gmail.com', 'iBQLPU0hxMjI6VCMqqJdWWZJIW1n99hKe3cYwPKPpuuZFbxA3+GNyFHGUgyC3GCJOBPX', 'alex12@gmail.comalex.jpg', 'LaganKhel', '9825878675', 2, 1357, 0),
('Ana', 'anash@gmail.com', 'JwBuTry5B3BPF0C/DVPUeaL5ISDi4dSQNqQI98ReUbwce8RpYNWnzB53ksJvOKR1ZiSE', 'anash@gmail.comana2.jpg', 'TinkuneField', '9806754981', 3, 1234, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`orderid`),
  ADD KEY `prodfk` (`prodId`),
  ADD KEY `userfk` (`userId`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`revid`),
  ADD KEY `reviews_ibfk_1` (`userid`),
  ADD KEY `reviews_ibfk_2` (`prodid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email_2` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `orderid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `revid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `prodfk` FOREIGN KEY (`prodId`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `userfk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`prodid`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
