<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
  <head>
  <style>
      footer {
        background-color: #222222;
        color: #ffffff;
        padding: 30px;
        text-align: center;
        font-size: 18px;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        align-items: center;
      }
      footer a {
        color: #ffffff;
        text-decoration: none;
        transition: color 0.2s ease-in-out;
      }
      footer a:hover {
        color: #ff9900;
      }
      footer p {
        margin-bottom: 10px;
        font-weight: bold;
        font-size: 20px;
        order: 1;
      }
      footer ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: flex-end;
        flex-wrap: wrap;
        gap: 20px;
        order: 2;
      }
      footer li {
        margin: 0 10px;
      }
      footer img {
        height: 50px;
        width: 50px;
        border-radius: 50%;
        margin: 0 5px;
        transition: transform 0.2s ease-in-out;
      }
      footer img:hover {
        transform: scale(1.2);
      }
      footer .contact-info {
        display: flex;
        flex-direction: column;
        gap: 10px;
        order: 3;
      }
      footer .contact-info span {
        display: block;
      }
      footer .contact-info i {
        margin-right: 10px;
        font-size: 20px;
        color: #ff9900;
      }
    </style>

  </head>
  <body>
    <footer>
      <div class="contact-info">
        <span><i class="fa fa-map-marker"></i> Baneshwor, Kathmandu, Nepal</span>
        <span><i class="fa fa-phone"></i> 01-20304050, 980489786</span>
        <span><i class="fa fa-envelope"></i> shopify@gmail.com</span>
      </div>
      <p>Shopify</p>
      <ul>
        <li>
          <a href="#">About Us</a>
        </li>
        <li>
          <a href="#">FAQ</a>
        </li>
        <li>
          <a href="#">Terms of Use</a>
        </li>
        <li>
          <a href="#">Privacy Policy</a>
        </li>
      </ul>
      <ul>
        <li>
          <a href="#">
            <img src="../pictures/webimages/face.png" alt="Social Media Icon 1">
          </a>
        </li>
        <li>
          <a href="#">
            <img src="../pictures/webimages/insta.png" alt="Social Media Icon 2">
          </a>
        </li>
        <li>
          <a href="#">
            <img src="../pictures/webimages/twitter.png" alt="Social Media Icon 3">
          </a>
        </li>
      </ul>
    </footer>
  </body>
</html>

